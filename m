From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Mon, 29 Mar 2010 21:23:40 +0200
Message-ID: <201003292123.40443.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003292017.16866.kdudka@redhat.com> <70318cbf1003291148w6b338b25v6801c3ec146af0f9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:19011 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752742Ab0C2TXq (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Mar 2010 15:23:46 -0400
In-Reply-To: <70318cbf1003291148w6b338b25v6801c3ec146af0f9@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Mon March 29 2010 20:48:38 Christopher Li wrote:
> On Mon, Mar 29, 2010 at 11:17 AM, Kamil Dudka <kdudka@redhat.com> wrote:
> > On Mon March 29 2010 20:05:08 Christopher Li wrote:
> >> Using enum namespace for member "namespace" has benefit here. It is
> >> clear that which set of value it belongs to. E.g. if you assign
> >> SYM_NODE into "namespace" member it *looks* is obvious wrong.
> > 
> > We are able to catch assignment of SYM_NODE to 'enum namespace'.  But we
> > are not able to catch (SYM_NODE | SYM_ENUM) to 'enum namespace', so that
> > the patch makes no difference.  Or am I missing anything?
> 
> I am refering to your patch in other email:
> 
> struct symbol_op {
> -          enum keyword type;
> +         int type;
> 
> That is worse. Because you make type as plain int, I can assign NS_KEYWORD

Have you tried it with sparse without my patch applied?  You indeed can assign 
NS_KEYWORD to 'enum keyword' and sparse is silent ;-)

> there and you wouldn't able to catch any thing right? So you make the enum
> so strict that
> we can't use it any more.
> 
> Currently the compiler might not able to catch it. But it look obvious
> wrong to human
> eye if you assign other class of enum there.

Type-info makes sense for compilers, analyzers, etc.  If you treat it as 
plain-text information for humans with no underlying support of that tools, 
it's equal to Hungarian notation IMO.

> > I don't think the code looks worse, nevertheless respect your attitude.
> 
> See my previous comment.
> 
> I just want to make sense of this thing. Currently I see a lot of down
> sides, forcing people to do more explicit cast or avoid using the enum
> type completely. What is the up side again?
> 
> Remember, too much warning can be a bad thing as well. It makes people
> don't want
> to use the tool or just turn off the warning completely. When I run sparse
> over its own source code, I consider those warning useless because I don't
> have a better
> way to fix it. I think the source code is fine as it is.

Sure, I don't object it anyhow.  As a C++ programmer I've certainly different 
attitude to type safety, thus biased.  I believe kernel developers would more 
likely agree with your point of view.

> BTW, I have move the enum warning to a new branch:
> 
> http://git.kernel.org/?p=devel/sparse/sparse.enum-warning.git;a=summary
> 
> Some people might find it useful in special occasions. I want to heard
> about it.

Looks great, though it really wasn't my intention to fork anything :-)

Kamil
