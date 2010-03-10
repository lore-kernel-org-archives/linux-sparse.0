From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Wed, 10 Mar 2010 22:03:27 +0100
Message-ID: <201003102203.27381.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003101705.36304.kdudka@redhat.com> <1268252841.20800.42.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43855 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757208Ab0CJVE4 (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Mar 2010 16:04:56 -0500
In-Reply-To: <1268252841.20800.42.camel@mj>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Wednesday 10 of March 2010 21:27:21 Pavel Roskin wrote:
> Maybe you could add a test case for the first patch?  What warnings does
> it remove?

Sorry, I over looked that question.  It's already covered by the second patch.  
Try to revert it and you'll see the noise.  It had been perhaps more obvious 
before reordering of the patches :-)

Nevertheless I'll write a separate test-case for e.g. the comparison of enum 
values.  Let me know if you have idea of yet another test-cases to improve 
the coverage.

Kamil
