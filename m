From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/3] fix discarded label statement
Date: Thu, 10 Nov 2016 15:45:17 +0100
Message-ID: <20161110144520.24965-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:38643 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933791AbcKJOpf (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 10 Nov 2016 09:45:35 -0500
Received: by mail-wm0-f51.google.com with SMTP id f82so36051688wmf.1
        for <linux-sparse@vger.kernel.org>; Thu, 10 Nov 2016 06:45:34 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Christopher Li <sparse@chrisli.org>

This series fixes a bug occurring when code contains an unsed statement.
In this case, not only the label is ignored, but the following statement
is also erroneously discarded together with the label.

This can be easily verified by inspecting the output of test-linearize
but can't be tested directly with the current test suite.
So patches 1 & 2 contain two small improvements to the test suite that
allow to test this sort of thing directly, the fix itself and its test
are in patch 3.

Luc Van Oostenryck (3):
  testsuite: add tag to ignore the output/error
  testsuite: check patterns presence or absence in output
  fix discarded label statement

 Documentation/test-suite               | 16 ++++++++++
 linearize.c                            |  2 +-
 validation/discarded-label-statement.c | 24 +++++++++++++++
 validation/test-suite                  | 54 ++++++++++++++++++++++++++++++++++
 4 files changed, 95 insertions(+), 1 deletion(-)
 create mode 100644 validation/discarded-label-statement.c

-- 
2.10.1

