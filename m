From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Possible incorrect linearization of code (master branch)
Date: Mon, 6 Mar 2017 15:22:19 +0000
Message-ID: <CACXZuxeNopu3Syg+TCL3TLnhwmA84qkQ1NsN4hjL-VLPi6ASYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f173.google.com ([209.85.223.173]:35602 "EHLO
        mail-io0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753640AbdCFPWV (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 6 Mar 2017 10:22:21 -0500
Received: by mail-io0-f173.google.com with SMTP id z13so71037279iof.2
        for <linux-sparse@vger.kernel.org>; Mon, 06 Mar 2017 07:22:21 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I have this test program:

extern char *incr(char *p);
char *incr(char *p) {
 char *tmp = p;
 tmp += 5;
 return tmp;
}
int main(const char *argv[]) {
 char *text =  "abcde";
 char *p = incr(text);
 return (*p == 'e') ? 0 : 1;
}

The linearizer outputs following which I think is incorrect as it is
missing a load.

incr:
.L0:
        <entry-point>
        cast.64     %r3 <- (64) %arg1
        add.64      %r4 <- %r3, $5
        ptrcast.64  %r5 <- (64) %r4
        ret.64      %r5

main:
.L2:
        <entry-point>
        call.64     %r10 <- incr, "abcde"
        setne.32    %r15 <- %r13, $101
        ret.32      %r15

If I change the return in main to be a if else block then correct code
is generated.

int main(const char *argv[]) {
 char *text =  "abcde";
 char *p = incr(text);
 // return (*p == 'e') ? 0 : 1;
 if (*p == 'e')
  return 0;
 else
  return 1;
}

main:
.L2:
        <entry-point>
        call.64     %r10 <- incr, "abcde"
        load.8      %r12 <- 0[%r10]
        scast.32    %r13 <- (8) %r12
        setne.32    %r15 <- %r13, $101
        ret.32      %r15
