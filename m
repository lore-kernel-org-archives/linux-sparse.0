From: Andreas Gruenbacher <agruenba@redhat.com>
Subject: rhashtable sparse annotations?
Date: Wed, 9 Sep 2015 16:14:59 +0200
Message-ID: <CAHc6FU5U81nz+1eZeg13A4CX-+v06mOyMwY0mXQYrbRKNV=Bmw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-la0-f54.google.com ([209.85.215.54]:34201 "EHLO
	mail-la0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751510AbbIIOPB (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 9 Sep 2015 10:15:01 -0400
Received: by laeb10 with SMTP id b10so7939234lae.1
        for <linux-sparse@vger.kernel.org>; Wed, 09 Sep 2015 07:14:59 -0700 (PDT)
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Nick Piggin <npiggin@kernel.dk>, Thomas Graf <tgraf@suug.ch>, Christopher Li <sparse@chrisli.org>
Cc: linux-sparse@vger.kernel.org

Hi,

I'm seeing the following sparse errors which are seemingly related to
the hlist_bl_for_each_entry_rcu() macro:

$ make C=1 fs/dcache.o
[...]
include/linux/rculist_bl.h:23:33: error: incompatible types in
comparison expression (different address spaces)
fs/dcache.c:2183:9: error: incompatible types in comparison expression
(different address spaces)
include/linux/rculist_bl.h:23:33: error: incompatible types in
comparison expression (different address spaces)
fs/dcache.c:2303:9: error: incompatible types in comparison expression
(different address spaces)

I'm hitting the same kinds of errors in the gfs2 rhashtable code as
well, but it doesn't seem to happen in the network code. Does this
need fixing in rhashtable?

Thanks,
Andreas
