From: Christopher Li <sparse@chrisli.org>
Subject: ptrlist-iterator performance on one wine source file
Date: Thu, 27 Jul 2017 11:05:38 -0400
Message-ID: <CANeU7QkRxYFB41o9dTMp=n=epsNTZLr1ZsjowW=DigRiVNkPjg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-pg0-f51.google.com ([74.125.83.51]:36995 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751113AbdG0PFj (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Thu, 27 Jul 2017 11:05:39 -0400
Received: by mail-pg0-f51.google.com with SMTP id y129so99078073pgy.4
        for <linux-sparse@vger.kernel.org>; Thu, 27 Jul 2017 08:05:39 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Linux-Sparse <linux-sparse@vger.kernel.org>, Dibyendu Majumdar <mobile@majumdar.org.uk>

Hi Luc,

Per our discussion, here is some test you are interested.
It show some measurable difference in ptrlist-iterator vs the
base before the patch series.

Step to reproduce:

git clone git://source.winehq.org/git/wine.git
cd win/dlls/usp10/tests

The test command:

time sparse -m64 -c -o usp10.o usp10.c -I. -I../../../include
-D__WINESRC__ -D_REENTRANT -fPIC -Wall -pipe -fno-strict-aliasing
-Wdeclaration-after-statement -Wempty-body -Wignored-qualifiers
-Wshift-overflow=2 -Wstrict-prototypes -Wtype-limits
-Wunused-but-set-parameter -Wvla -Wwrite-strings -Wpointer-arith
-Wlogical-op -gdwarf-2 -gstrict-dwarf -g -O2

I run the test on ptrlist-iterator from the git url you send out.
Here is 3 runs each on ptrlist-iterator and the base line commit.

with ptrlist-iterator d55cac721a060882df02f40aab8824d210d9dc6f

real 0m25.764s
user 0m25.430s
sys 0m0.227s

real 0m25.746s
user 0m25.424s
sys 0m0.219s

real 0m25.800s
user 0m25.326s
sys 0m0.201s

with base(rc4) ec3f72e981792a86a9e002471a06d61ecd5c6675

real 0m23.625s
user 0m23.311s
sys 0m0.190s

real 0m23.489s
user 0m23.002s
sys 0m0.195s

real 0m23.321s
user 0m23.043s
sys 0m0.185s


Chris
