From: Christopher Li <sparse@chrisli.org>
Subject: [GIT PULL] Makefile: debug target V2
Date: Tue, 22 Aug 2017 01:50:32 -0400
Message-ID: <CANeU7QnzNoc4yOEO-Sv0PbzN7ZoG4vqJYxotEOxnDxh18BDU+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-yw0-f182.google.com ([209.85.161.182]:35267 "EHLO
        mail-yw0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbdHVFue (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Tue, 22 Aug 2017 01:50:34 -0400
Received: by mail-yw0-f182.google.com with SMTP id s187so17283043ywf.2
        for <linux-sparse@vger.kernel.org>; Mon, 21 Aug 2017 22:50:33 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Linux-Sparse <linux-sparse@vger.kernel.org>

The git branch are here:

https://git.kernel.org/pub/scm/devel/sparse/chrisl/sparse.git/log/?h=debug-target-v2

compare to V1, most change happen on the second to last patch.
the V1 patch as the issue of the "make check" does not build
the top level test-linearize which cause some check fail.

Change the default build  target only build release
version of sparse, test-linearize and test-parsing.

"make debug" will build all debug version of the program
"make release" will build all release version of the program.
"make check" will build "make all debug" before
doing the check.

Chris
