From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Tue, 9 Mar 2010 20:06:23 +0100
Message-ID: <201003092006.23686.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003091446.50092.kdudka@redhat.com> <1268159719.23196.12.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:1414 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755630Ab0CITHt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Tue, 9 Mar 2010 14:07:49 -0500
In-Reply-To: <1268159719.23196.12.camel@mj>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Tuesday 09 of March 2010 19:35:19 Pavel Roskin wrote:
> And that's where it happens (in the code being checked):
>
> static int do_alg_test(const char *alg, u32 type, u32 mask)
> {
>         return crypto_has_alg(alg, type, mask ?: CRYPTO_ALG_TYPE_MASK) ?
>                0 : -ENOENT;
> }

Thank you for the feedback!  Just a few words to explain what happened.  I 
didn't take the conditional operator into account at all while working on 
this.  Today's patch should not only solve the crash, but also extend the 
enum type analysis for expressions containing conditional operators, so far 
without any test cases ...  and yes, it caused yet another crash instead :-)

> I removed the outside conditional, and sparse would still crash on this:
>
> crypto_has_alg(alg, type, mask ?: CRYPTO_ALG_TYPE_MASK);
>
> but not on this:
>
> crypto_has_alg(alg, type, mask ? mask: CRYPTO_ALG_TYPE_MASK);
>
> Apparently, the "?:" notation is confusing sparse now.

To be frank, I've never seen that notation before.  From what I understand, 
the variants above should be equivalent with each other, right?

Kamil
