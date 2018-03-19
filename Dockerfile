FROM ruby:alpine

#ADD https://github.com/stelligent/cfn_nag/archive/v0.3.23.tar.gz /usr/local/cfn_nag/

RUN gem install cfn-nag


CMD [ 'ash' ]

