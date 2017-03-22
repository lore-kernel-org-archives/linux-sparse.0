From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm issue with handling of phisrc instruction
Date: Wed, 22 Mar 2017 16:46:24 +0000
Message-ID: <CACXZuxdzxg_+rXu-OEUe+CwbbW+C-0CHZ=1wRrGa1ysptGDozA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:35844 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S964892AbdCVQq1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Mar 2017 12:46:27 -0400
Received: by mail-io0-f171.google.com with SMTP id l7so68332922ioe.3
        for <linux-sparse@vger.kernel.org>; Wed, 22 Mar 2017 09:46:25 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi

I am trying to see if sparse-llvm can handle unsimplified IR output
from linearizer. I think there is a problem in how it handles phisrc.
Example:

static int testfunc(int i) {
return i-6;
}

Linearied IR:
testfunc:
.L0:
        <entry-point>
        store.32    %arg1 -> 0[i]
        load.32     %r1 <- 0[i]
        sub.32      %r2 <- %r1, $6
        phisrc.32   %phi1(return) <- %r2
        br          .L1

.L1:
        phi.32      %r3 <- %phi1(return)
        ret.32      %r2


But the LLVM IR is missing a store instruction corresponding to the
phisrc instruction:

define internal i32 @testfunc(i32 %ARG1) {
L0:
  %i_0000029F015CAA78 = alloca i32
  %0 = alloca i32
  %1 = ptrtoint i32* %i_0000029F015CAA78 to i64
  %2 = add i64 %1, 0
  %3 = inttoptr i64 %2 to i32*
  store i32 %ARG1, i32* %3
  %4 = ptrtoint i32* %i_0000029F015CAA78 to i64
  %5 = add i64 %4, 0
  %6 = inttoptr i64 %5 to i32*
  %load_target = load i32, i32* %6
  %R2 = sub i32 %load_target, 6
  br label %L1

L1:                                               ; preds = %L0
  %7 = load i32, i32* %0
  ret i32 %R2
}

Basically we need a store from %i_0000029F015CAA78 to %0 output for
the phisrc instruction above.

I see that it emits stores for phi_users when it encounters a phisrc
but the phi_users list appears to be empty here. Is that expected? If
so, then how to fix this issue i.e. add the missing store?

Thanks and Regards
Dibyendu
