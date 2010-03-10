From: Kamil Dudka <kdudka@redhat.com>
Subject: Re: Sparse crash when mixing int and enum in ternary operator
Date: Wed, 10 Mar 2010 21:44:14 +0100
Message-ID: <201003102144.14378.kdudka@redhat.com>
References: <1268097872.16227.10.camel@mj> <201003101705.36304.kdudka@redhat.com> <1268252841.20800.42.camel@mj>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:14994 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757037Ab0CJUpt (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 10 Mar 2010 15:45:49 -0500
In-Reply-To: <1268252841.20800.42.camel@mj>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pavel Roskin <proski@gnu.org>
Cc: Josh Triplett <josh@joshtriplett.org>, Christopher Li <sparse@chrisli.org>, linux-sparse@vger.kernel.org

On Wednesday 10 of March 2010 21:27:21 Pavel Roskin wrote:
> That makes sense for certain kinds of software, where crash is too
> costly, but in case of sparse, I'd rather see it crash than ignore a
> condition that may indicate an error elsewhere (perhaps both in sparse
> and in the code it checks).
>
> I thing using assert() would be a better approach.  It's already used in
> sparse.
>
> I checked the whole kernel using assert in place of the NULL checks, and
> there have been no crashes.

I completely agree with that.  Let's give some time to sparse developers to 
respond.  If nobody objects, I'll change it to asserts.

> Maybe you could add a test case for the first patch?  What warnings does
> it remove?  What is "="?  Is it assignment or initialization or both?

Both of them.  Maybe worth to add a test-case for the initialization to make 
it more obvious...

> How about comparisons?

Definitely not.  That was the main goal of the 0001-Wenum-to-int patch.  It 
was really noisy since enum values are first implicitly casted to ints and 
then compared.  So there was no way to type-safely compare two enums without 
producing 6 lines of warnings.

> A better description would be nice.

Sure thing.  I didn't realize it was ambiguous.

Thank you for the review!

Kamil
