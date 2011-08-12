From: Christopher Li <sparse@chrisli.org>
Subject: Re: [RFC PATCH 0/2] check for identical exprs on LHS and RHS of '&&'
Date: Fri, 12 Aug 2011 12:16:11 -0700
Message-ID: <CANeU7Qkpz7MAhcHrBxZ+u7mGfzBpTYhAHjHs_Jy_GQHfCvOppw@mail.gmail.com>
References: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:47694 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754167Ab1HLTQM (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 12 Aug 2011 15:16:12 -0400
Received: by qwk3 with SMTP id 3so1700670qwk.19
        for <linux-sparse@vger.kernel.org>; Fri, 12 Aug 2011 12:16:11 -0700 (PDT)
In-Reply-To: <1312967235-23817-1-git-send-email-chrisf@ijw.co.nz>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Chris Forbes <chrisf@ijw.co.nz>
Cc: linux-sparse@vger.kernel.org

On Wed, Aug 10, 2011 at 2:07 AM, Chris Forbes <chrisf@ijw.co.nz> wrote:
> * Do people consider this a worthwhile check to make?
> * Am I "doing it right" with the expression walking?
> * Are there other cases which people would be interested in?

To evaluate a particular check, it is useful to look at the out come of the
check, and how complex it is the change.

e.g. How many the error caught by this check on some open source
projects. And how high is the false positive.

The expression walking is on the right track.

Chris
