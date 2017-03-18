From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Possible linearizer issue
Date: Sat, 18 Mar 2017 11:41:26 +0000
Message-ID: <CACXZuxeuav4vrT=xKxLcV7RpUET8NM7VLuviTNr4N_XfGQxmHQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f45.google.com ([209.85.214.45]:35401 "EHLO
        mail-it0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751302AbdCRLl2 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 18 Mar 2017 07:41:28 -0400
Received: by mail-it0-f45.google.com with SMTP id m27so47150810iti.0
        for <linux-sparse@vger.kernel.org>; Sat, 18 Mar 2017 04:41:27 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi

I am investigating a failure in one of the tests. The generated
linearized code has instructions such as:

.L363:
 br          VOID, .L366, .L439
.L366:
 load.32     %r413 <- 44[%arg1]
 br          %r413, .L368, .L369
.L368:
 load.64     %r415 <- 0[s7813er]
 call.32     %r416 <- printf, %r415, $2
 br          .L369
.L369:
 phisrc.32   %phi97(rc) <- $2
 br          .L439
.L439:
 phi.32      %r557 <- %phi95(rc), VOID, %phi97(rc), VOID, VOID, VOID

The test program is here:

https://github.com/dibyendumajumdar/dmr_c/blob/master/tests/set1/cq2.c

Regards
Dibyendu
