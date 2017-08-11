From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [GIT PULL] remove single-store shortcut
Date: Fri, 11 Aug 2017 16:40:36 +0200
Message-ID: <20170811144036.46750-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:37602 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752765AbdHKOk6 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 11 Aug 2017 10:40:58 -0400
Received: by mail-wm0-f68.google.com with SMTP id t138so6703883wmt.4
        for <linux-sparse@vger.kernel.org>; Fri, 11 Aug 2017 07:40:58 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

Chris,
PLease consider these two patches for inclusion in the release.

This will remove an unsafe 'shortcut' made during the SSA
construction which create problems for undefined variables.
The most visible problem being that the processing of files
containing such undefined variable can easily run into infinite
loops but even if not, such processing is as best ill-defined,
plainly wrong in most cases.

[since these patches will be part of the release, I've slightly
 changes the message commit. The patch in itself is unchanged
 since the last days and correspond to what have been tested].

----------------------------------------------------------------
The following changes since commit fa71b7ac0594c9ddf81ec27753280cffef702489:

  Adding gcc attribute no_gccisr (2017-07-13 23:57:09 -0700)

are available in the git repository at:

  git://github.com/lucvoo/sparse.git remove-singlestore-shortcut

for you to fetch changes up to 64c9129b5beee61f0a311556259d97d7e56d2879:

  Remove single-store shortcut (2017-08-11 16:24:13 +0200)

----------------------------------------------------------------
Luc Van Oostenryck (2):
      testsuite: add support for commands with timeout
      Remove single-store shortcut

 Documentation/test-suite    |  4 ++++
 flow.c                      | 39 ++-------------------------------------
 validation/infinite-loop0.c | 11 +++++++++++
 validation/test-suite       |  7 +++++++
 4 files changed, 24 insertions(+), 37 deletions(-)
 create mode 100644 validation/infinite-loop0.c
