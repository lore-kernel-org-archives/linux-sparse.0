From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC v0 0/4] Give a type to constants too
Date: Sat, 11 Mar 2017 16:47:21 +0100
Message-ID: <20170311154725.87906-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:35719 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754067AbdCKPto (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Sat, 11 Mar 2017 10:49:44 -0500
Received: by mail-wm0-f68.google.com with SMTP id z63so3366875wmg.2
        for <linux-sparse@vger.kernel.org>; Sat, 11 Mar 2017 07:49:31 -0800 (PST)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Dibyendu Majumdar <mobile@majumdar.org.uk>, Christopher Li <sparse@chrisli.org>, Jeff Garzik <jeff@garzik.org>, Pekka Enberg <penberg@kernel.org>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

This is a RFC for giving a type to constants/PSEUDO_VALs.

Not having this info if fine for the linearization/simplification
but is quite painful once trying to generate code of it.

This serie try to do this by:
- shuffling some fields in struct pseudo to allow
  PSEUDO_VAL to have the ::sym field too without
  without increasing the size of the structure.
- mechanically initialize each PSEUDO_VAL's ::sym
  with the appropriate type.

This serie have been tested on the test suite only.
Thsi serie also doesn't make any use yet of this type info.

Luc Van Oostenryck (4):
  be more careful with concat_user_list()
  make space for PSEUDO_VAL have a type
  add helper pseudo_type()
  give a type to PSEUDO_VALs

 flow.c      |  5 +++--
 linearize.c | 17 +++++++++--------
 linearize.h | 24 +++++++++++++++++++++---
 memops.c    |  2 +-
 simplify.c  | 18 +++++++++---------
 5 files changed, 43 insertions(+), 23 deletions(-)

-- 
2.11.1

