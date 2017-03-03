From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm handling of function call arguments
Date: Fri, 3 Mar 2017 06:56:49 +0000
Message-ID: <CACXZuxdDm87uytHxCuqKSYt6UnBjR1wM7C5Nu3zLmkcsDS_kew@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-ua0-f176.google.com ([209.85.217.176]:35345 "EHLO
        mail-ua0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751083AbdCCG5i (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 3 Mar 2017 01:57:38 -0500
Received: by mail-ua0-f176.google.com with SMTP id q7so70491855uaf.2
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 22:56:49 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am starting a new thread on the function call argument handling
issue. If the argument is a pseudo value, sparse-llvm is using the
instruction's type as the type of the argument which results in
invalid LLVM IR.

Previous threads:

http://www.spinics.net/lists/linux-sparse/msg04772.html
http://www.spinics.net/lists/linux-sparse/msg04778.html


Regards
Dibyendu
