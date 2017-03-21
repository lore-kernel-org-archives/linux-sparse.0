From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Another potential issue with linearized output
Date: Tue, 21 Mar 2017 15:54:12 +0000
Message-ID: <CACXZuxetXE1QQ2jK5Pc5+FQB-vN3pguUNm8FuJ5hZ23C845KKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f52.google.com ([209.85.214.52]:34278 "EHLO
        mail-it0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756686AbdCUPyO (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 21 Mar 2017 11:54:14 -0400
Received: by mail-it0-f52.google.com with SMTP id y18so2535345itc.1
        for <linux-sparse@vger.kernel.org>; Tue, 21 Mar 2017 08:54:13 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

When I try to compile following test (see link) in sparse-llvm - LLVM says:

Instruction does not dominate all uses!
  %load_target = load i32, i32* %191
  %R122 = icmp eq i32 %load_target4, %load_target
Instruction does not dominate all uses!
  %load_target = load i32, i32* %191
  %R283 = icmp eq i32 %load_target4, %load_target
Instruction does not dominate all uses!
  %load_target = load i32, i32* %191
  %R522 = icmp eq i32 %load_target4, %load_target

I have not yet investigated what the issue is but I thought it best to
post the test case so that it can be validated.

https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/bugs/cq3.c

Thanks and Regards

Dibyendu
