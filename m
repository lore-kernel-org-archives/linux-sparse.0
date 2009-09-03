From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: [PATCH] add warnings enum-to-int and int-to-enum
Date: Thu, 3 Sep 2009 20:54:01 +0200
Message-ID: <200909032054.01900.kdudka@redhat.com>
References: <20090830153202.4dc5c58c@s6510> <200909031347.35371.kdudka@redhat.com> <70318cbf0909031138s4c066005vcd8b8f614723b05f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:7184 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755026AbZICSzL (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Thu, 3 Sep 2009 14:55:11 -0400
In-Reply-To: <70318cbf0909031138s4c066005vcd8b8f614723b05f@mail.gmail.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Stephen Hemminger <shemminger@vyatta.com>, linux-sparse@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>, Morten Welinder <terra@gnome.org>

On Thursday 03 of September 2009 20:38:24 Christopher Li wrote:
> I think it is cleaner to have one single place to look for the ctype of
> an expression.We don't have to convert it to int type. I think most of the
> sparse code can deal with enum type any way. I don't like the dual
> personality of expressions.

Two personalities are still not so many ... have you ever looked to the gcc 
code? :-)

[...]

> I don't see why it is hard to split. Can we just make the code which add
> new options and issue new warnings to a separate patch? We shouldn't
> need to reverse engineering the old behavior to do that.

I didn't say hard, but actually not useful from my point of view. If it's easy 
for you to split my patch to the two pieces, you are welcome to have a go at 
that. We can still wait for opinion of the original authors. Perhaps they can 
bring some light to this problem.

Kamil
