From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Sparse-llvm question regarding handling of phi/phsrc instructions
Date: Thu, 7 Sep 2017 17:04:06 +0100
Message-ID: <CACXZuxfKGmGEtOm8DOz=J9f77eSMyQGT8NRpc_6tEBncuJuy7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-vk0-f42.google.com ([209.85.213.42]:35806 "EHLO
        mail-vk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752200AbdIGQEI (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 7 Sep 2017 12:04:08 -0400
Received: by mail-vk0-f42.google.com with SMTP id m142so254661vkf.2
        for <linux-sparse@vger.kernel.org>; Thu, 07 Sep 2017 09:04:07 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

The following code snippet:

static int test_do(void) {
    int a = 0;
    int count = 27;
    switch (count % 8) {
    case 0: do {  a++;
    case 7:       a++;
    case 6:       a++;
    case 5:       a++;
    case 4:       a++;
    case 3:       a++;
    case 2:       a++;
    case 1:       a++;
            } while ((count -= 8) > 0);
    }
    return a;
}

Results in following linear output:

test_do:
.L0:
        <entry-point>
        phisrc.32   %phi3(a) <- $0
        phisrc.32   %phi4(a) <- $0
        phisrc.32   %phi6(a) <- $0
        phisrc.32   %phi8(a) <- $0
        phisrc.32   %phi10(a) <- $0
        phisrc.32   %phi12(a) <- $0
        phisrc.32   %phi14(a) <- $0
        phisrc.32   %phi16(a) <- $0
        phisrc.32   %phi18(a) <- $0
        phisrc.32   %phi20(count) <- $27
        br          .L7

.L10:
        phi.32      %r3 <- %phi18(a), %phi19(a)
        add.32      %r4 <- %r3, $1
        phisrc.32   %phi17(a) <- %r4
        phi.32      %r5 <- %phi16(a), %phi17(a)
        add.32      %r6 <- %r5, $1
        phisrc.32   %phi15(a) <- %r6
        phi.32      %r7 <- %phi14(a), %phi15(a)
        add.32      %r8 <- %r7, $1
        phisrc.32   %phi13(a) <- %r8
        phi.32      %r9 <- %phi12(a), %phi13(a)
        add.32      %r10 <- %r9, $1
        phisrc.32   %phi11(a) <- %r10
        phi.32      %r11 <- %phi10(a), %phi11(a)
        add.32      %r12 <- %r11, $1
        phisrc.32   %phi9(a) <- %r12
        br          .L7

.L7:
        phi.32      %r13 <- %phi8(a), %phi9(a)
        add.32      %r14 <- %r13, $1
        phisrc.32   %phi7(a) <- %r14
        phi.32      %r15 <- %phi6(a), %phi7(a)
        add.32      %r16 <- %r15, $1
        phisrc.32   %phi5(a) <- %r16
        phi.32      %r17 <- %phi4(a), %phi5(a)
        add.32      %r18(a) <- %r17, $1
        phisrc.32   %phi2(a) <- %r18(a)
        phisrc.32   %phi19(a) <- %r18(a)
        phi.32      %r19 <- %phi20(count), %phi21(count)
        add.32      %r21 <- %r19, $-8
        setgt.32    %r23 <- %r21, $0
        phisrc.32   %phi21(count) <- %r21
        cbr         %r23, .L10, .L1

.L1:
        phi.32      %r24 <- %phi2(a), %phi3(a)
        ret.32      %r24


This is translated to following LLVM IR:

define internal i32 @test_do() {
L0:
  %0 = alloca i32
  %1 = alloca i32
  %2 = alloca i32
  %3 = alloca i32
  %4 = alloca i32
  %5 = alloca i32
  %6 = alloca i32
  %7 = alloca i32
  %8 = alloca i32
  %9 = alloca i32
  store i32 0, i32* %9
  store i32 0, i32* %7
  store i32 0, i32* %6
  store i32 0, i32* %5
  store i32 0, i32* %4
  store i32 0, i32* %3
  store i32 0, i32* %2
  store i32 0, i32* %1
  store i32 0, i32* %0
  store i32 27, i32* %8
  br label %L2

L1:                                               ; preds = %L2
  %10 = load i32, i32* %0
  %R4 = add i32 %10, 1
  store i32 %R4, i32* %1
  %11 = load i32, i32* %1
  %R6 = add i32 %11, 1
  store i32 %R6, i32* %2
  %12 = load i32, i32* %2
  %R8 = add i32 %12, 1
  store i32 %R8, i32* %3
  %13 = load i32, i32* %3
  %R10 = add i32 %13, 1
  store i32 %R10, i32* %4
  %14 = load i32, i32* %4
  %R12 = add i32 %14, 1
  store i32 %R12, i32* %5
  br label %L2

L2:                                               ; preds = %L1, %L0
  %15 = load i32, i32* %5
  %R14 = add i32 %15, 1
  store i32 %R14, i32* %6
  %16 = load i32, i32* %6
  %R16 = add i32 %16, 1
  store i32 %R16, i32* %7
  %17 = load i32, i32* %7
  %R18 = add i32 %17, 1
  store i32 %R18, i32* %9
  store i32 %R18, i32* %0
  %18 = load i32, i32* %8
  %R21 = add i32 %18, -8
  %R23 = icmp sgt i32 %R21, 0
  %R231 = zext i1 %R23 to i32
  store i32 %R21, i32* %8
  %cond = icmp ne i32 %R231, 0
  br i1 %cond, label %L1, label %L3

L3:                                               ; preds = %L2
  %19 = load i32, i32* %9
  ret i32 %19
}

It seems to me that 'a' ends up having 9 different slots on the stack,
but it should really be merged into one slot, i.e. we should detect
that the phis all related to the same symbol, and create only one
alloca?

Regards
Dibyendu
