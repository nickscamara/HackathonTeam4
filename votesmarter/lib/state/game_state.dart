import 'dart:core';
import 'dart:math';
import '../model/question.dart';

class GameState {

  final Map<String, Set<Question>> questions = {
    "civics": { new Question(
      question: "Civic Question",
      answers: ["1", "2", "3"],
      correctAnswer: "2",
      sourceURL: null,
      explanation: null,
      incorrectAnswers: ["1", "3"],
      type: "civics",
      categoryName: "civics"
    ) },
    "policy": { new Question(
      question: "Policy Question",
      answers: ["1", "2", "3"],
      correctAnswer: "1",
      sourceURL: null,
      explanation: null,
      incorrectAnswers: ["2", "3"],
      type: "policy",
      categoryName: "policy"
    ) },
    "candidates": { new Question(
      question: "candidates Question",
      answers: ["1", "2", "3"],
      correctAnswer: "3",
      sourceURL: null,
      explanation: null,
      incorrectAnswers: ["1", "2"],
      type: "candidates",
      categoryName: "candidates"
    ) }, 
  };
  final Random _random = Random();

  // We need to track the current round we are on
  int _currentGameRound;
  get currentGameRound => _currentGameRound;

  int _lives;
  get currentNumberOfLives => _lives;

  void decrementLives() {
    _lives--;
  }

  int _numCivicsCorrect, _numCivicsTotal;
  get calculateCivicsScore => ((_numCivicsCorrect / _numCivicsTotal).floor() * 100);

  int _numPolicyCorrect, _numPolicyTotal;
  get calculatePolicyScore => ((_numPolicyCorrect / _numPolicyTotal).floor() * 100);

  int _numCandidatesCorrect, _numCandidatesTotal;
  get calculateCandidatesScore => ((_numCandidatesCorrect / _numCandidatesTotal).floor() * 100);

  get calculateTotalScore => (calculatePolicyScore + calculateCivicsScore + calculateCandidatesScore);

  void incrementGameRound() {
    _currentGameRound++;
  }

  Question getQuestionByTopic(String topic) {
    Question proposedQuestion;
    if (topic == "crown") {
      String randomCategory = ((questions.keys).toList())[_random.nextInt(3)];
      proposedQuestion = questions[randomCategory].elementAt(_random.nextInt(questions[randomCategory].length));
    } else
      proposedQuestion = questions[topic].elementAt(_random.nextInt(questions[topic].length));
    questions[topic].remove(proposedQuestion);
    if (topic == "civics") {
        _numCivicsTotal++;
    } else if (topic == "policy") {
      _numPolicyTotal++;
    } else if (topic == "candidates") {
      _numCandidatesTotal++;
    }
    return proposedQuestion;
  }

  bool isUserCorrect(Question question, String userAnswer) {
    if (userAnswer == question.getCorrectAnswer()) {
      // Correct
      if (question.getQuestionType() == "civics") {
        _numCivicsCorrect++;
      } else if (question.getQuestionType() == "policy") {
        _numPolicyCorrect++;
      } else if (question.getQuestionType() == "candidates") {
        _numCandidatesCorrect++;
      }
      return true;
    } else {
      _lives--;
      return false;
    }
  }
  GameState() {
    _currentGameRound = 1;
    _lives = 5;
  }



}