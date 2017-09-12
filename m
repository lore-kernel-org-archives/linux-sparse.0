From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Handling of local variables in the backend
Date: Tue, 12 Sep 2017 22:54:42 +0100
Message-ID: <CACXZuxd2XOKBaTnPEGEy-XZPTg_PJrA_XnNUfbbHm2X7zxKcmA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f169.google.com ([209.85.217.169]:33564 "EHLO
        mail-ua0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751017AbdILVyo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 12 Sep 2017 17:54:44 -0400
Received: by mail-ua0-f169.google.com with SMTP id g47so16804925uad.0
        for <linux-sparse@vger.kernel.org>; Tue, 12 Sep 2017 14:54:43 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

One issue I am facing at the moment is that there is no explicit
alloca for each symbol that is used in a function - so that the
backend has to detect when a symbol is accessed and then do alloca to
associate stack space. In the LLVM backend this is not so much an
issue as LLVM allows instructions to be inserted at a particular point
- so my code just ensures that all the allocas go at the start of the
function as required by LLVM. But I am having trouble with the other
backend that doesn't have this capability.

I think that there is no easy way to identify all the symbols used for
which stack space is needed and do the allocas at the start - is
there? I mean the only way is to go through all the instructions to
find these references as far as I know.

Is there a better way?

Regards
Dibyendu
