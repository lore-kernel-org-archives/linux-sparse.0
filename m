From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: Possible memory leak in sparse-llvm
Date: Thu, 2 Mar 2017 19:03:45 +0000
Message-ID: <CACXZuxdZOeWHSgGGHELNO2gGA2ffUq6W8-DiTr51WcimPc3aXQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f177.google.com ([209.85.223.177]:34257 "EHLO
        mail-io0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751148AbdCBUJo (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 2 Mar 2017 15:09:44 -0500
Received: by mail-io0-f177.google.com with SMTP id 90so61318071ios.1
        for <linux-sparse@vger.kernel.org>; Thu, 02 Mar 2017 12:09:22 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

I think that in sparse-llvm.c the calls to calloc() in a few places
should be alloca() as only temporary memory is needed. Else the memory
needs to be freed.

Regards
Dibyendu
