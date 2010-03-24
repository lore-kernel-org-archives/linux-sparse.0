From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Wed, 24 Mar 2010 11:51:00 +0100
Message-ID: <201003241151.00318.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003211627.14164.kdudka@redhat.com> <70318cbf1003240307m6be38384l3524923484e493ce@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1540 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752488Ab0CXKvc convert rfc822-to-8bit (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Mar 2010 06:51:32 -0400
In-Reply-To: <70318cbf1003240307m6be38384l3524923484e493ce@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

Hi Chris,

On Wed March 24 2010 11:07:04 Christopher Li wrote:
> That is just too much. Most of the warning is coming from enum or
> operation. e.g.
> .type = KW_SPECIFIER | KW_SHORT,
> lookup_keyword(token->ident, NS_KEYWORD | NS_TYPEDEF);
> 
> I think those source are fine. Force enum cast there make the source code

I completely agree on that.

> lworse. We can add special case for enum OR enum, more special cases.
> But where is the end?

Let's handle the bitwise operators and we'll see.

> It comes down to we try to treat enum as a different type than int. It

From my point of view it _is_ different type than int.  At least gcc 
distinguishes among enum and int on the level I grab the type-info.

> seems works for the simple case. But in real world, people do use enum as
> int type and expect enum can mix with int.

What about just changing the default?  We can keep the current -Wenum-mismatch 
(in its working variant) and those two new warnings provide only as option.

> At this point I am leaning towards moving this enum warning to a topic
> branch. Let the people who want to use it play with it first. It currently
> give too many warning.

Sure.

> If people do feel that warning is useful, even bette, it catch some real
> bugs. I will consider merge it again.

Yes, it makes sense to me.

> You obvious spend a lot of time on this. I feel bad about pushing it back
> too.

Spent time should be definitely not considered as a criterion
for inclusion ;-)

Kamil
