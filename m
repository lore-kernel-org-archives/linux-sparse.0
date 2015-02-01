From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH 0/4] Teach sparse to display data/initial values
Date: Sun,  1 Feb 2015 03:19:42 +0100
Message-ID: <1422757186-8007-1-git-send-email-luc.vanoostenryck@gmail.com>
References: <CANeU7QnQWRRB1kmt7KOjuJ4PFasefaX91yPZ-DEYxE2qUzxX3A@mail.gmail.com>
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f170.google.com ([209.85.212.170]:36046 "EHLO
	mail-wi0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754334AbbBACUa (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 31 Jan 2015 21:20:30 -0500
Received: by mail-wi0-f170.google.com with SMTP id bs8so9486836wib.1
        for <linux-sparse@vger.kernel.org>; Sat, 31 Jan 2015 18:20:28 -0800 (PST)
In-Reply-To: <CANeU7QnQWRRB1kmt7KOjuJ4PFasefaX91yPZ-DEYxE2qUzxX3A@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org
Cc: linux-sparse@vger.kernel.org, linux@rasmusvillemoes.dk

The patches in this serie implement the display of toplevel variable's initializer.
It should allow to easily investigate the bug reported here: http://article.gmane.org/gmane.comp.parsers.sparse/4080
but can be usefull for others things.

For convenience, this patch series can also be found at git://github.com/looxix/sparse.git show-data


Luc Van Oostenryck (4):
 Add support for '-vdata', the equivalent of '-ventry' but for data
 Add support for show_data()
 Teach sparse to display data/initial values
 Small test/exemple for using '-vdata'

 lib.c                  |  2 ++
 lib.h                  |  1 +
 linearize.c            | 86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 linearize.h            |  1 +
 sparse.c               |  3 +++
 validation/show_data.c | 75 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 6 files changed, 168 insertions(+)

