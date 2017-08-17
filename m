From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [RFC PATCH 0/4] simple, registrable, promotable & friends
Date: Fri, 18 Aug 2017 00:35:54 +0200
Message-ID: <20170817223558.21258-1-luc.vanoostenryck@gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wr0-f196.google.com ([209.85.128.196]:36566 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753324AbdHQWgJ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 17 Aug 2017 18:36:09 -0400
Received: by mail-wr0-f196.google.com with SMTP id f8so2247751wrf.3
        for <linux-sparse@vger.kernel.org>; Thu, 17 Aug 2017 15:36:09 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: linux-sparse@vger.kernel.org
Cc: Christopher Li <sparse@chrisli.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>

The goal of this series is tosolve the issues with the 
current is_simple_{var,type}():
- the name was less than optimal, I've choosen 'promotable'
- fix the case for structs & unions.

Luc Van Oostenryck (4):
  move is_simple_XXX() to linearize.c
  fold is_simple_var() into simple_access()
  rename 'simple_{var,access}' by promatable_...'
  fix promotion of struct & union

 linearize.c | 45 +++++++++++++++++++++++++++++++++++++++++----
 symbol.h    | 33 ---------------------------------
 2 files changed, 41 insertions(+), 37 deletions(-)

-- 
2.14.0

