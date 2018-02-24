# README

## Usage

* Logging
    * Stores to mysql (as of 2018-02)
        * Maybe elasticsearch in the future
* slack commands
    * `warietan -h`
    * `warietan えらんで A B C`
    * `warietan echo A`

## TODOs

* Implement `-h`
* Setup auto-deployment triggered by github

## System archtecture

(Meaningful only for ujihisa)

* Slack -> kkr public ip
* GitHub -> kkr public ip
* kkr nginx -> ubu16 puma
