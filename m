From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Sun, 21 Mar 2010 16:27:13 +0100
Message-ID: <201003211627.14164.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <70318cbf1003101356u48688264na5c9d71bc1ef4300@mail.gmail.com> <201003131822.49308.kdudka@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:15206 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750799Ab0CUP3C (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Sun, 21 Mar 2010 11:29:02 -0400
In-Reply-To: <201003131822.49308.kdudka@redhat.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Pavel Roskin <proski@gnu.org>, Josh Triplett <josh@joshtriplett.org>, linux-sparse@vger.kernel.org

On Saturday 13 of March 2010 18:22:48 Kamil Dudka wrote:
> I was unsuscessfully looking for an implementation of stack within sparse.
> So that I used the implicit one instead.  I know it's pretty bad idea, but
> I am not aware of any easy way to handle it better.

I could probably use a list instead.  Nevertheless the evaluation of EXPR_COND 
also works recursively on the runtime stack - see evaluate_expression() and 
evaluate_conditional_expression().  So that I don't think it's an actual 
problem here.

Let me know if the patch needs some additional improvements.

Kamil
