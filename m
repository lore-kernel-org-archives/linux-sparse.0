From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/2] Fix illegal simplification of volatile stores
Date: Sat, 11 Nov 2017 17:24:58 +0100
Message-ID: <20171111162500.69476-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:56133 "EHLO
        mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751390AbdKKQ1J (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Nov 2017 11:27:09 -0500
Received: by mail-wm0-f67.google.com with SMTP id 9so2415188wme.4
        for <linux-sparse@vger.kernel.org>; Sat, 11 Nov 2017 08:27:09 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This series inhibit the illegal simplification of redundant
stores when the stores are volatiles ones.

Luc Van Oostenryck (2):
  add test case for bogus volatile simplification
  fix: volatile stores must not be simplified

 memops.c                     |  6 +++++-
 validation/memops-volatile.c | 15 +++++----------
 2 files changed, 10 insertions(+), 11 deletions(-)

-- 
2.14.0

