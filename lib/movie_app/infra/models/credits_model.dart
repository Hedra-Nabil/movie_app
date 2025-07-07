import 'package:equatable/equatable.dart';

class CreditsResponse {
  final int id;
  final List<Cast> cast;
  final List<Crew> crew;

  CreditsResponse({required this.id, required this.cast, required this.crew});

  factory CreditsResponse.fromJson(Map<String, dynamic> json) {
    return CreditsResponse(
      id: json['id'],
      cast: (json['cast'] as List).map((e) => Cast.fromJson(e)).toList(),
      crew: (json['crew'] as List).map((e) => Crew.fromJson(e)).toList(),
    );
  }
}

class Cast {
  final int id;
  final String name;
  final String? profilePath;
  final String character;
  final int gender;

  Cast({
    required this.id,
    required this.name,
    this.profilePath,
    required this.character,
    required this.gender,
  });

  factory Cast.fromJson(Map<String, dynamic> json) {
    return Cast(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      character: json['character'],
      gender: json['gender'] ?? 0,
    );
  }

  String get fullProfilePath {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
    // Return a placeholder image if no profile path is available
    return 'https://via.placeholder.com/500x750.png?text=No+Image';
  }
}

class Crew extends Equatable {
  final int id;
  final String name;
  final String? profilePath;
  final String department;
  final String job;
  final int gender;

  const Crew({
    required this.id,
    required this.name,
    this.profilePath,
    required this.department,
    required this.job,
    required this.gender,
  });

  factory Crew.fromJson(Map<String, dynamic> json) {
    return Crew(
      id: json['id'],
      name: json['name'],
      profilePath: json['profile_path'],
      department: json['department'],
      job: json['job'],
      gender: json['gender'] ?? 0,
    );
  }

  String get fullProfilePath {
    if (profilePath != null) {
      return 'https://image.tmdb.org/t/p/w500$profilePath';
    }
    return 'https://via.placeholder.com/500x750.png?text=No+Image';
  }

  @override
  List<Object?> get props => [id, name, profilePath, department, job, gender];
}
