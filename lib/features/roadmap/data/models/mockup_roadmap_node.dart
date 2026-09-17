import 'package:MatchIn/features/roadmap/data/models/roadmap_node.dart';
import 'package:MatchIn/features/roadmap/data/models/skill_task.dart';
import 'package:flutter/material.dart';

final roadmapNodes = [
  const RoadmapNode(
    title: 'Dart Fundamentals',
    subtitle: 'Foundation',
    status: RoadmapTaskStatus.completed,
    xp: 100,
    icon: Icons.code_rounded,
    tasks: [
      SkillTask(
        id: 'dart_1',
        title: 'Variables & Data Types',
        description: 'Understand String, int, double, bool, lists, and maps in Dart.',
        duration: '20 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=5xlVP04905w',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://dart.dev/language/variables',
          ),
        ],
      ),
      SkillTask(
        id: 'dart_2',
        title: 'Control Flow & Loops',
        description: 'Master if/else, switch expressions, for, while, and do-while loops.',
        duration: '25 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://dart.dev/language/control-flow',
          ),
        ],
      ),
      SkillTask(
        id: 'dart_3',
        title: 'Functions & Null Safety',
        description: 'Learn named/positional parameters, arrow syntax, and sound null safety.',
        duration: '35 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=iYgP2x1J4-w',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://dart.dev/null-safety',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'OOP & Clean Code',
    subtitle: 'Foundation',
    status: RoadmapTaskStatus.completed,
    xp: 150,
    icon: Icons.architecture_rounded,
    tasks: [
      SkillTask(
        id: 'oop_1',
        title: 'Classes & Inheritance',
        description: 'Build robust object-oriented Dart classes with abstract types and mixins.',
        duration: '30 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=Z52z8x2w33I',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://dart.dev/language/classes',
          ),
        ],
      ),
      SkillTask(
        id: 'oop_2',
        title: 'SOLID Principles in Dart',
        description: 'Single Responsibility, Open-Closed, Liskov, Interface Segregation, DI.',
        duration: '45 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=pTB30aXS77U',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'Flutter Fundamentals',
    subtitle: 'Core Flutter',
    status: RoadmapTaskStatus.completed,
    duration: '~2 hours',
    xp: 250,
    icon: Icons.flutter_dash_rounded,
    tasks: [
      SkillTask(
        id: 'flutter_1',
        title: 'Flutter Widgets & Layouts',
        description: 'Master Container, Column, Row, Stack, ListView, and ScreenUtil responsive layout.',
        duration: '30 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=b_sQ9bMltGU',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.flutter.dev/ui/widgets',
          ),
        ],
      ),
      SkillTask(
        id: 'flutter_2',
        title: 'Stateless vs StatefulWidget',
        description: 'Understand widget lifecycle, setState, and performance optimization.',
        duration: '35 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.flutter.dev/development/ui/interactive',
          ),
        ],
      ),
      SkillTask(
        id: 'flutter_3',
        title: 'Navigation with GoRouter',
        description: 'Declarative routing, parameters, transitions, and nested navigation shell.',
        duration: '40 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=Vl0Vv_Q_8Y4',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://pub.dev/packages/go_router',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'State Management',
    subtitle: 'Engineering',
    status: RoadmapTaskStatus.completed,
    duration: '~3 hours',
    xp: 300,
    icon: Icons.layers_rounded,
    tasks: [
      SkillTask(
        id: 'state_1',
        title: 'Bloc & Cubit Fundamentals',
        description: 'Learn how to separate presentation state logic from UI using flutter_bloc.',
        duration: '45 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=knMvKPKBzGE',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://bloclibrary.dev/',
          ),
        ],
      ),
      SkillTask(
        id: 'state_2',
        title: 'Sealed Class States & Listeners',
        description: 'Use Dart 3 sealed class states, BlocBuilder, BlocListener, and BlocConsumer.',
        duration: '40 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://bloclibrary.dev/#/architecture',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'REST APIs',
    subtitle: 'Engineering',
    status: RoadmapTaskStatus.completed,
    duration: '~2 hours',
    xp: 250,
    icon: Icons.cloud_sync_rounded,
    tasks: [
      SkillTask(
        id: 'api_1',
        title: 'Dio HTTP Client Setup',
        description: 'Configure DioConsumer, headers, timeout options, and interceptors.',
        duration: '35 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=8V42tD1E1z4',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://pub.dev/packages/dio',
          ),
        ],
      ),
      SkillTask(
        id: 'api_2',
        title: 'JSON Parsing & Models',
        description: 'Convert JSON payloads into strongly-typed Dart model classes.',
        duration: '30 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.flutter.dev/data-and-backend/json',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'Clean Architecture',
    subtitle: 'Architecture',
    status: RoadmapTaskStatus.completed,
    duration: '~4 hours',
    xp: 400,
    icon: Icons.account_tree_rounded,
    tasks: [
      SkillTask(
        id: 'arch_1',
        title: 'Layer Separation Principles',
        description: 'Separate Presentation, Domain/Data, and Core infrastructure layers.',
        duration: '50 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=7k7S_Z0b0y8',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://blog.cleancoder.com/uncle-bob/2012/08/13/the-clean-architecture.html',
          ),
        ],
      ),
      SkillTask(
        id: 'arch_2',
        title: 'Dependency Injection with GetIt',
        description: 'Register lazy singletons, services, and repositories cleanly with GetIt.',
        duration: '40 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://pub.dev/packages/get_it',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'Testing & CI/CD',
    subtitle: 'Quality',
    status: RoadmapTaskStatus.active,
    duration: '~3 hours',
    xp: 300,
    icon: Icons.verified_user_rounded,
    tasks: [
      SkillTask(
        id: 'test_1',
        title: 'Unit Testing Cubits & Repos',
        description: 'Write unit tests for business logic, Cubit state emissions, and repositories.',
        duration: '40 min',
        isCompleted: true,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=RDY6WwUSx5E',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.flutter.dev/cookbook/testing/unit/introduction',
          ),
        ],
      ),
      SkillTask(
        id: 'test_2',
        title: 'Widget Testing & Golden Tests',
        description: 'Test UI components, user interactions, and visual layout stability.',
        duration: '45 min',
        isCompleted: false,
        resources: [
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.flutter.dev/cookbook/testing/widget/introduction',
          ),
        ],
      ),
      SkillTask(
        id: 'test_3',
        title: 'GitHub Actions for Flutter',
        description: 'Automate linting, unit testing, and APK builds on every pull request.',
        duration: '50 min',
        isCompleted: false,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=sS_wB2p29Xg',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.github.com/en/actions',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'Real World Project',
    subtitle: 'Job Ready',
    status: RoadmapTaskStatus.locked,
    duration: '~8 hours',
    xp: 700,
    icon: Icons.stars_rounded,
    tasks: [
      SkillTask(
        id: 'project_1',
        title: 'Project Architecture Setup',
        description: 'Initialize Clean Architecture structure, theme tokens, and routing.',
        duration: '60 min',
        isCompleted: false,
        resources: [
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.flutter.dev/',
          ),
        ],
      ),
      SkillTask(
        id: 'project_2',
        title: 'Feature Integration & Auth',
        description: 'Build full login, registration, and persistent user sessions.',
        duration: '90 min',
        isCompleted: false,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=VPvVD8t02U8',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'Performance Optimization',
    subtitle: 'Optimization',
    status: RoadmapTaskStatus.locked,
    duration: '~3 hours',
    xp: 350,
    icon: Icons.speed_rounded,
    tasks: [
      SkillTask(
        id: 'perf_1',
        title: 'Flutter DevTools Profiling',
        description: 'Use DevTools timeline, memory inspector, and performance overlay.',
        duration: '45 min',
        isCompleted: false,
        resources: [
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.flutter.dev/tools/devtools/overview',
          ),
        ],
      ),
    ],
  ),
  const RoadmapNode(
    title: 'App Store Deployment',
    subtitle: 'Release',
    status: RoadmapTaskStatus.locked,
    duration: '~4 hours',
    xp: 500,
    icon: Icons.rocket_launch_rounded,
    tasks: [
      SkillTask(
        id: 'deploy_1',
        title: 'Google Play & App Store Release',
        description: 'Configure App Icons, Android App Bundle, iOS provisioning, and store metadata.',
        duration: '60 min',
        isCompleted: false,
        resources: [
          TaskResource(
            type: TaskResourceType.youtube,
            title: 'YouTube',
            url: 'https://www.youtube.com/watch?v=0-8Dbl0h1sY',
          ),
          TaskResource(
            type: TaskResourceType.documentation,
            title: 'Docs',
            url: 'https://docs.flutter.dev/deployment/android',
          ),
        ],
      ),
    ],
  ),
];
