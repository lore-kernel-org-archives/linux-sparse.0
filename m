From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH 2/5] sparse: Enable unhandled validation tests
Date: Wed, 24 Aug 2011 14:05:51 -0700
Message-ID: <CANeU7Q=xwx6TNA9PE_30=9i+KrCF0gRfXm2UPAXBpCg-7uncPg@mail.gmail.com>
References: <1314021451-24808-1-git-send-email-penberg@kernel.org>
	<1314021451-24808-2-git-send-email-penberg@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-qw0-f46.google.com ([209.85.216.46]:42247 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751826Ab1HXVFw (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Wed, 24 Aug 2011 17:05:52 -0400
Received: by qwk3 with SMTP id 3so1050459qwk.19
        for <linux-sparse@vger.kernel.org>; Wed, 24 Aug 2011 14:05:51 -0700 (PDT)
In-Reply-To: <1314021451-24808-2-git-send-email-penberg@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Pekka Enberg <penberg@kernel.org>
Cc: linux-sparse@vger.kernel.org, Linus Torvalds <torvalds@linux-foundation.org>

On Mon, Aug 22, 2011 at 6:57 AM, Pekka Enberg <penberg@kernel.org> wrote:
> This patch enables unhandled tests that did not have "check-name" specified.
> It's pointless not to run them.

Good catch. Applied.

Chris
