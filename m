From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Potential incorrect simplification
Date: Tue, 28 Mar 2017 13:40:22 +0100
Message-ID: <CACXZuxeRXsYWgwihs1nmmTYaLoyhw+PDAy6jEemkZJFpySdfQA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:36834 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932220AbdC1MlR (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 28 Mar 2017 08:41:17 -0400
Received: by mail-it0-f45.google.com with SMTP id e75so54407808itd.1
        for <linux-sparse@vger.kernel.org>; Tue, 28 Mar 2017 05:40:57 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

I am getting a failure in following test when simplifications are enabled:

extern int printf(const char *, ...);

int main(void)
{
   struct{
     int twobit:2;
     int       :1;
     int threebit:3;
     unsigned int onebit:1;
   } s3;

   s3.onebit = 1;
   if(s3.onebit != 1){
      printf("Be especially careful with 1-bit fields! %d\n", (int) s3.onebit);
      return 1;
   }
   return 0;
}

The output (truncated) from linearizer without simplications is this:

main:
.L0:
        <entry-point>
        load.32     %r1 <- 0[s3]
        shl.32      %r2 <- $1, $6
        and.32      %r3 <- %r1, $-65
        or.32       %r4 <- %r3, %r2
        store.32    %r4 -> 0[s3]
        load.32     %r5 <- 0[s3]
        lsr.32      %r6 <- %r5, $6
        cast.32     %r7 <- (1) %r6
        setne.32    %r8 <- %r7, $1
        br          %r8, .L1, .L2

But if simplifications are on then we get:

main:
.L0:
        <entry-point>
        and.32      %r3 <- %r4, $-65
        or.32       %r4 <- %r3, $64
        lsr.32      %r6 <- %r4, $6
        cast.32     %r7 <- (1) %r6
        setne.32    %r8 <- %r7, $1
        br          %r8, .L1, .L3

Regards
Dibyendu
