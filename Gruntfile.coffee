# Generated on 2014-09-05 using generator-reveal 0.3.9
module.exports = (grunt) ->

    grunt.initConfig

        watch:

            livereload:
                options:
                    livereload: true
                files: [
                    'index.html'
                    'slides/{,*/}*.{md,html}'
                    'js/*.js'
                ]

            index:
                files: [
                    'templates/_index.html'
                    'templates/_section.html'
                    'slides/list.json'
                ]
                tasks: ['buildIndex']

            coffeelint:
                files: ['Gruntfile.coffee']
                tasks: ['coffeelint']

            jshint:
                files: ['js/*.js']
                tasks: ['jshint']
        
        connect:

            livereload:
                options:
                    port: 9000
                    # Change hostname to '0.0.0.0' to access
                    # the server from outside.
                    hostname: 'localhost'
                    base: '.'
                    open: true
                    livereload: true

        coffeelint:

            options:
                indentation:
                    value: 4
                max_line_length:
                    level: 'ignore'

            all: ['Gruntfile.coffee']

        jshint:

            options:
                jshintrc: '.jshintrc'

            all: ['js/*.js']

        copy:

            dist:
                files: [{
                    expand: true
                    src: [
                        'slides/**'
                        'bower_components/**'
                        'js/**',
                        'img/**'
                        'css/**',
                        'CNAME',
                        'examples/**'
                    ]
                    dest: 'dist/'
                },{
                    expand: true
                    src: ['index.html']
                    dest: 'dist/'
                    filter: 'isFile'
                }]

        shell:
            pushGithubPages:
                command: [
                  'chmod +x scripts/pushGhPages.sh',
                  'sh scripts/pushGhPages.sh'
                  ].join('&&')
            prepareGithubPages:
                command: [
                  'chmod +x scripts/prepareGhPages.sh',
                  'sh scripts/prepareGhPages.sh'
                ].join('&&')

    # Load all grunt tasks.
    require('load-grunt-tasks')(grunt)

    grunt.registerTask 'buildIndex',
        'Build index.html from templates/_index.html and slides/list.json.',
        ->
            indexTemplate = grunt.file.read 'templates/_index.html'
            sectionTemplate = grunt.file.read 'templates/_section.html'
            slides = grunt.file.readJSON 'slides/list.json'

            html = grunt.template.process indexTemplate, data:
                slides:
                    slides
                section: (slide) ->
                    grunt.template.process sectionTemplate, data:
                        slide:
                            slide
            grunt.file.write 'index.html', html

    grunt.registerTask 'test',
        '*Lint* javascript and coffee files.', [
            'coffeelint'
        ]

    grunt.registerTask 'serve',
        'Run presentation locally and start watch process (living document).', [
            'buildIndex'
            'connect:livereload'
            'watch'
        ]

    grunt.registerTask 'server', ->
        grunt.log.warn
        'The `server` task has been deprecated.
         Use `grunt serve` to start a server.'
        grunt.task.run ['serve']

    grunt.registerTask 'dist',
        'Save presentation files to *dist* directory.', [
            'test'
            'buildIndex'
            'copy'
        ]

    
    grunt.registerTask 'deploy',
        'Deploy to Github Pages', [
            'shell:prepareGithubPages'
            'dist'
            'shell:pushGithubPages'
        ]
    

    # Define default task.
    grunt.registerTask 'default', [
        'test'
        'server'
    ]