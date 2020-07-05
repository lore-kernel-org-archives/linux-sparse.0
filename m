From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 00/15] tidy-up options / reorganize lib.c
Date: Sun,  5 Jul 2020 15:02:05 +0200
Message-ID: <20200705130220.26230-1-luc.vanoostenryck@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726792AbgGENC3 (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sun, 5 Jul 2020 09:02:29 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B82C061794
        for <linux-sparse@vger.kernel.org>; Sun,  5 Jul 2020 06:02:29 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id w16so39593361ejj.5
        for <linux-sparse@vger.kernel.org>; Sun, 05 Jul 2020 06:02:29 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

A lot of content in lib.c have been added by just appending at the
bottom of what was already present. As consequence, things are now
not well organized at all, especially when related to the options.
So, reorganize things a little bit here:
*) move all helpers on top
*) keep things alphabetically sorted
*) move options parsing in a separate file
*) move predefine-related stuff in a separate file


Luc Van Oostenryck (15):
  options: let handle_onoff_switch() use null terminated arrays
  options: move -Wsparse-all's processing out of handle_onoff_switch()
  options: move on top the definition of warning type enums
  options: make Wsparse_error less special
  options: handle_onoff_switch() can handle any flags, not only warnings
  options: move helpers up
  options: alphasort the handle_switch_[a-zA_Z]()
  options: avoid spaces between function name and arguments list
  options: move declaration of tabstop out of "token.h"
  options: add a small helper: handle_switch_finalize()
  options: move option parsing in a separate file
  options: keep the options sorted
  cleanup: move predefines in a separate file
  cleanup: move parsing helpers to parse.c
  cleanup: move hexval() to utils.c

 Makefile    |    2 +
 lib.c       | 1256 +--------------------------------------------------
 lib.h       |  119 +----
 options.c   |  998 ++++++++++++++++++++++++++++++++++++++++
 options.h   |  137 ++++++
 parse.c     |   38 ++
 predefine.c |  225 +++++++++
 token.h     |    1 -
 utils.c     |   17 +
 utils.h     |    4 +
 10 files changed, 1427 insertions(+), 1370 deletions(-)
 create mode 100644 options.c
 create mode 100644 options.h
 create mode 100644 predefine.c

-- 
2.27.0
