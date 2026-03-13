class JobModel {
  final String id;
  final String title;
  final String description;
  final String location;
  final String category;
  final String jobDuration;
  final List<String> skills;
  final String wage;
  final String phone;
  
  // User (job creator)
  final Map<String, dynamic>? user;
  
  // Location geometry
  final Map<String, dynamic>? locationGeo;
  
  // Additional fields
  final List<String>? images;
  final bool isBlocked;
  final String? blockedReason;
  final double averageRating;
  final int reviewCount;
  final List<Map<String, dynamic>> reviews;
  
  final DateTime createdAt;
  final DateTime updatedAt;

  JobModel({
    required this.id,
    required this.title,
    required this.description,
    required this.location,
    required this.category,
    required this.jobDuration,
    required this.skills,
    required this.wage,
    required this.phone,
    this.user,
    this.locationGeo,
    this.images,
    this.isBlocked = false,
    this.blockedReason,
    this.averageRating = 0,
    this.reviewCount = 0,
    this.reviews = const [],
    required this.createdAt,
    required this.updatedAt,
  });

  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      location: json['location'] ?? '',
      category: json['category'] ?? 'General Service',
      jobDuration: json['jobDuration'] ?? 'Depends on worksite',
      skills: List<String>.from(json['skills'] ?? []),
      wage: json['wage']?.toString() ?? '0',
      phone: json['phone'] ?? '',
      user: json['user'] is Map ? json['user'] as Map<String, dynamic> : null,
      locationGeo: json['locationGeo'] is Map
          ? json['locationGeo'] as Map<String, dynamic>
          : null,
      images: json['images'] != null
          ? List<String>.from(json['images'] as List<dynamic>)
          : null,
      isBlocked: json['isBlocked'] ?? false,
      blockedReason: json['blockedReason'],
      averageRating: (json['averageRating'] as num?)?.toDouble() ?? 0,
      reviewCount: json['reviewCount'] ?? 0,
      reviews: json['reviews'] != null
          ? List<Map<String, dynamic>>.from(
              (json['reviews'] as List<dynamic>)
                  .map((r) => r as Map<String, dynamic>))
          : [],
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'] as String)
          : DateTime.now(),
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'] as String)
          : DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'description': description,
      'location': location,
      'category': category,
      'jobDuration': jobDuration,
      'skills': skills,
      'wage': wage,
      'phone': phone,
      'user': user,
      'locationGeo': locationGeo,
      'images': images,
      'isBlocked': isBlocked,
      'blockedReason': blockedReason,
      'averageRating': averageRating,
      'reviewCount': reviewCount,
      'reviews': reviews,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }

  JobModel copyWith({
    String? id,
    String? title,
    String? description,
    String? location,
    String? category,
    String? jobDuration,
    List<String>? skills,
    String? wage,
    String? phone,
    Map<String, dynamic>? user,
    Map<String, dynamic>? locationGeo,
    List<String>? images,
    bool? isBlocked,
    String? blockedReason,
    double? averageRating,
    int? reviewCount,
    List<Map<String, dynamic>>? reviews,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JobModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      location: location ?? this.location,
      category: category ?? this.category,
      jobDuration: jobDuration ?? this.jobDuration,
      skills: skills ?? this.skills,
      wage: wage ?? this.wage,
      phone: phone ?? this.phone,
      user: user ?? this.user,
      locationGeo: locationGeo ?? this.locationGeo,
      images: images ?? this.images,
      isBlocked: isBlocked ?? this.isBlocked,
      blockedReason: blockedReason ?? this.blockedReason,
      averageRating: averageRating ?? this.averageRating,
      reviewCount: reviewCount ?? this.reviewCount,
      reviews: reviews ?? this.reviews,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  String toString() {
    return 'JobModel(id: $id, title: $title, category: $category, wage: $wage)';
  }
}