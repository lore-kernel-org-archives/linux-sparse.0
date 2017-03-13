From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm outstanding fixes
Date: Mon, 13 Mar 2017 12:08:24 +0000
Message-ID: <CACXZuxeKgVsaz_7TKseghcxzxZNdvK0gU-MhLxtmzYye8Uwz_g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-io0-f175.google.com ([209.85.223.175]:36733 "EHLO
        mail-io0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750802AbdCMMI1 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Mon, 13 Mar 2017 08:08:27 -0400
Received: by mail-io0-f175.google.com with SMTP id l7so82167649ioe.3
        for <linux-sparse@vger.kernel.org>; Mon, 13 Mar 2017 05:08:26 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi,

This is just a summary of the fixes that are not yet in any patch series:

+ Incorrect generation of GEP offsets due to offset being unsigned.
+ op_fpcast implementation
+ op_setval implementation
+ Fix for variadic function call based upon type information in pseudo values
+ Fix for local variables and simple assignments, including support
for floating type values.

Regards
Dibyendu
