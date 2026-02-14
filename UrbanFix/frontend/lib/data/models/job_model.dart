class JobModel {
  final String id;
  final String userId; // Person who created the job
  final String? assignedWorkerId; // Worker assigned to job
  final String title;
  final String description;
  final String category; // plumber, electrician, painter, etc.
  final String location;
  final double? budget;
  final String status; 
  // open, assigned, in_progress, completed, cancelled

  final DateTime? createdAt;
  final DateTime? updatedAt;

  JobModel({
    required this.id,
    required this.userId,
    this.assignedWorkerId,
    required this.title,
    required this.description,
    required this.category,
    required this.location,
    this.budget,
    required this.status,
    this.createdAt,
    this.updatedAt,
  });

  // ==========================
  // From JSON
  // ==========================
  factory JobModel.fromJson(Map<String, dynamic> json) {
    return JobModel(
      id: json['_id'] ?? '',
      userId: json['userId'] ?? '',
      assignedWorkerId: json['assignedWorkerId'],
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      category: json['category'] ?? '',
      location: json['location'] ?? '',
      budget: json['budget'] != null
          ? (json['budget'] as num).toDouble()
          : null,
      status: json['status'] ?? 'open',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      updatedAt: json['updatedAt'] != null
          ? DateTime.parse(json['updatedAt'])
          : null,
    );
  }

  // ==========================
  // To JSON
  // ==========================
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'userId': userId,
      'assignedWorkerId': assignedWorkerId,
      'title': title,
      'description': description,
      'category': category,
      'location': location,
      'budget': budget,
      'status': status,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
    };
  }

  // ==========================
  // Copy With
  // ==========================
  JobModel copyWith({
    String? id,
    String? userId,
    String? assignedWorkerId,
    String? title,
    String? description,
    String? category,
    String? location,
    double? budget,
    String? status,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return JobModel(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      assignedWorkerId:
          assignedWorkerId ?? this.assignedWorkerId,
      title: title ?? this.title,
      description: description ?? this.description,
      category: category ?? this.category,
      location: location ?? this.location,
      budget: budget ?? this.budget,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
