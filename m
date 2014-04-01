From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH v2 1/2] evaluate: split out implementation of compatible_assignment_types
Date: Tue, 1 Apr 2014 00:46:05 -0700
Message-ID: <CANeU7Qm5pHTZCSk83ToxXqDPw4RfEaOTnE6YntQa+KEYVZUi0w@mail.gmail.com>
References: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1394364717.git.john@keeping.me.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qg0-f48.google.com ([209.85.192.48]:42148 "EHLO
	mail-qg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751199AbaDAHqG (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 1 Apr 2014 03:46:06 -0400
Received: by mail-qg0-f48.google.com with SMTP id j107so8507159qga.7
        for <linux-sparse@vger.kernel.org>; Tue, 01 Apr 2014 00:46:05 -0700 (PDT)
In-Reply-To: <afd69e2697f3d3da96b74c06501fd2fb1fc5cba2.1394364717.git.john@keeping.me.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: John Keeping <john@keeping.me.uk>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Sun, Mar 9, 2014 at 4:32 AM, John Keeping <john@keeping.me.uk> wrote:
> This will allow us to reuse the logic when processing a transparent
> union by checking each member in turn without printing a warning unless
> none of the members match.

Both patches applied.

Chris
