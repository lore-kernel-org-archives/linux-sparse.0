From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 1/2] Add warning about duplicate initializers
Date: Sun, 30 Mar 2014 21:25:31 -0700
Message-ID: <CANeU7Q=jBeWsty6WoiRLs2cVF_QvkuZm16iVs5iWcA8UDB2CVA@mail.gmail.com>
References: <alpine.LFD.2.11.1403301018060.16237@i7.linux-foundation.org>
	<20140330203740.GA27368@leaf>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qc0-f180.google.com ([209.85.216.180]:49012 "EHLO
	mail-qc0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751388AbaCaEZc (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Mon, 31 Mar 2014 00:25:32 -0400
Received: by mail-qc0-f180.google.com with SMTP id w7so8279144qcr.25
        for <linux-sparse@vger.kernel.org>; Sun, 30 Mar 2014 21:25:31 -0700 (PDT)
In-Reply-To: <20140330203740.GA27368@leaf>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@joshtriplett.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Hans Verkuil <hverkuil@xs4all.nl>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 30, 2014 at 1:37 PM, Josh Triplett <josh@joshtriplett.org> wrote:
> On Sun, Mar 30, 2014 at 10:20:41AM -0700, Linus Torvalds wrote:
>> Noticed this while looking at an independent bug reported by Hans
>> Verkuil.
>>
>> Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
>
> Reviewed-by: Josh Triplett <josh@joshtriplett.org>

This change looks good. Will apply.

Chris
