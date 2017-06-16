From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Trying to debug strange issue
Date: Fri, 16 Jun 2017 20:20:41 +0100
Message-ID: <CACXZuxd-_hMEpn6TQKNFPjNpYZc8+j0XOS=1bUOjdjZWmQb0Cw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:36884 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750864AbdFPTUn (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 16 Jun 2017 15:20:43 -0400
Received: by mail-wm0-f51.google.com with SMTP id d73so31044413wma.0
        for <linux-sparse@vger.kernel.org>; Fri, 16 Jun 2017 12:20:43 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

I am trying to implement the ability to compile a string buffer rather
than a file. So I have created something similar to sparse_file() but
it takes a buffer instead.

First issue was that sparse assumes that the argv array has at least
one element. Otherwise there is a segmentation fault.

Secondly if the file list is empty then the sparse initialization step
doesn't occur - so I have disabled the check for empty file list for
this use case.

Anyway the issue is that the linearized instructions are coming out
with 0 size. I was wondering if there is a quick way to locate what is
going wrong.

The same C snippet when put into a file is handled fine.

Thanks and Regards

Dibyendu
