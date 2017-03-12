From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm potential error in linearized output
Date: Sun, 12 Mar 2017 13:04:30 +0000
Message-ID: <CACXZuxfajgS=+3MEw-ECnsmnpZqu8WXLhjrvsfjkD1X-+dNxbw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:33206 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755733AbdCLNEc (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 09:04:32 -0400
Received: by mail-io0-f175.google.com with SMTP id f84so69711370ioj.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 06:04:31 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

I have the following test:

extern int printf(const char *, ...);
static char *randomletters = "agqwewbxklpfgytuorz";
int main(void)
{
 int i;
 for (i = 0; i < 20; i++) {
  int key;
  key = randomletters[i];
  printf("Inserting %d\n", key);
 }
 return 0;
}

The linearized output is:

main:
.L0:
        <entry-point>
        phisrc.32   %phi4(i) <- $0
        br          .L4
.L4:
        phi.32      %r1(i) <- %phi4(i), %phi5(i)
        setlt.32    %r2 <- %r1(i), $20
        br          %r2, .L1, .L5
.L1:
        load.64     %r3 <- 0[randomletters]
        scast.64    %r5 <- (32) %r1(i)
        add.64      %r6 <- %r3, %r5
        load.8      %r7 <- 0[%r6]
        scast.32    %r8 <- (8) %r7
        symaddr.64  %r9 <- <anon symbol:0000020914372028>
        call.32     %r11 <- printf, %r9, %r8
        add.32      %r13 <- %r1(i), $1
        phisrc.32   %phi5(i) <- %r13
        br          .L4
.L5:
        ret.32      $0

The following instruction looks incorrect to me:

        load.64     %r3 <- 0[randomletters]


Thanks and Regards

Dibyendu
