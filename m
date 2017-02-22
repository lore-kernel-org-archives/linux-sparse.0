From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/5] improve detection of overlapping initializers
Date: Wed, 22 Feb 2017 16:30:01 +0100
Message-ID: <20170222153006.3035-1-luc.vanoostenryck@gmail.com>
References: <20170221110355.GD300@arm.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f194.google.com ([209.85.128.194]:32999 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933008AbdBVPgv (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Wed, 22 Feb 2017 10:36:51 -0500
Received: by mail-wr0-f194.google.com with SMTP id s27so837434wrb.0
        for <linux-sparse@vger.kernel.org>; Wed, 22 Feb 2017 07:36:36 -0800 (PST)
In-Reply-To: <20170221110355.GD300@arm.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Mark Rutland <mark.rutland@arm.com>, Stephen Boyd <stephen.boyd@linaro.org>, Will Deacon <will.deacon@arm.com>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This aims at improving the detection of overlapping initializers by
- introduce some warning flags for finer control
- fix the detection when the overlap is not on the first element
- ann an exception when the initializer cover the whole range.

For convenience, thsi series can also be found at:
	git://github.com/lucvoo/sparse.git sent/array-range-init


Luc Van Oostenryck (5):
  use option: '-Woverride-init'
  add test case for warnings about overlapping initializers
  allow to warn on all overlapping initializers
  fix checking of overlapping initializer
  ignore whole-range overlapping initializer

 expand.c                        |  44 +++++++++++++++--
 lib.c                           |   5 ++
 lib.h                           |   3 ++
 validation/Woverride-init-def.c |  14 ++++++
 validation/Woverride-init-no.c  |  12 +++++
 validation/Woverride-init-yes.c |  14 ++++++
 validation/field-override.c     | 101 ++++++++++++++++++++++++++++++++++++++++
 7 files changed, 188 insertions(+), 5 deletions(-)
 create mode 100644 validation/Woverride-init-def.c
 create mode 100644 validation/Woverride-init-no.c
 create mode 100644 validation/Woverride-init-yes.c
 create mode 100644 validation/field-override.c

-- 
2.11.1

