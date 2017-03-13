From: Dibyendu Majumdar <mobile@majumdar.org.uk>
Subject: sparse-llvm test cases
Date: Mon, 13 Mar 2017 01:13:36 +0000
Message-ID: <CACXZuxdrwNpr3yVkV=pBYty9jSjK_-HA9zDXwpfyB5evv_8Uzw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-it0-f49.google.com ([209.85.214.49]:37708 "EHLO
        mail-it0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933322AbdCMBNi (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 12 Mar 2017 21:13:38 -0400
Received: by mail-it0-f49.google.com with SMTP id g138so23584920itb.0
        for <linux-sparse@vger.kernel.org>; Sun, 12 Mar 2017 18:13:38 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

Hi

As a measure of the progress made in the past few days (thanks Luc!) -
I have a bunch of test cases that now pass. More tests will be added.

Note that there are fixes in my project related to handling of fpcast,
setval, and local variables that are not yet reflected in sparse code
so these tests will not pass yet in sparse.

The tests that pass are here:

https://github.com/dibyendumajumdar/dmr_c/tree/master/tests

These are not exactly in the format currently used for testing sparse.
It will be nice however to add all the test cases to the official
sparse repository.

Thanks and Regards
Dibyendu
