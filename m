From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Mon, 29 Mar 2010 20:17:16 +0200
Message-ID: <201003292017.16866.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <20100327092949.GB9548@feather> <70318cbf1003291105v44334f0et82575f62a8c187f8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39887 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754704Ab0C2SRP (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 29 Mar 2010 14:17:15 -0400
In-Reply-To: <70318cbf1003291105v44334f0et82575f62a8c187f8@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Pavel Roskin <proski@gnu.org>, linux-sparse@vger.kernel.org

On Mon March 29 2010 20:05:08 Christopher Li wrote:
> Using enum namespace for member "namespace" has benefit here. It is clear
> that which set of value it belongs to. E.g. if you assign SYM_NODE into
> "namespace" member it *looks* is obvious wrong.

We are able to catch assignment of SYM_NODE to 'enum namespace'.  But we are 
not able to catch (SYM_NODE | SYM_ENUM) to 'enum namespace', so that the patch 
makes no difference.  Or am I missing anything?

> It also helps people understand which set of value belongs to
> "namespace" member.
> Make "namespace" a plain int, that message is lost. It become very
> confusing for new comer
> what value was allowed in this int type.

The identifier ns_mask sounds clear to me, maybe namespace_mask would be 
better.  But yes ... I am not a new comer here :-)

> So back to my point. It seems making the enum more strict is just make up
> rules and gain nothing in real life. It makes code looks worse just to
> make strict enum type
> happy.

I don't think the code looks worse, nevertheless respect your attitude.

Kamil
