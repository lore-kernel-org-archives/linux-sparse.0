From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] fix missing base type examination
Date: Sat, 25 Nov 2017 10:31:13 +0100
Message-ID: <20171125093115.95791-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:39383 "EHLO
        mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750819AbdKYJdg (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 25 Nov 2017 04:33:36 -0500
Received: by mail-wm0-f42.google.com with SMTP id x63so26271512wmf.4
        for <linux-sparse@vger.kernel.org>; Sat, 25 Nov 2017 01:33:36 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is to add te missing
examination of the base type in evaluate_dereference().

Luc Van Oostenryck (2):
  add test case unexamined base type
  fix: evaluate_dereference() unexamined base type

 evaluate.c                                |  2 +-
 validation/bugs/unexamined-base-type-00.c | 28 ++++++++++++++++++++++++++++
 2 files changed, 29 insertions(+), 1 deletion(-)
 create mode 100644 validation/bugs/unexamined-base-type-00.c


The series is available for testing at:
	git://github.com/lucvoo/sparse-dev.git fix-unexamined

-- Luc Van Oostenryck
