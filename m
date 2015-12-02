From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 0/3] Minor enhancements and fixes
Date: Wed, 2 Dec 2015 13:52:30 -0500
Message-ID: <565F3DEE.7060506@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:58487 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751209AbbLBSwb (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 2 Dec 2015 13:52:31 -0500
In-Reply-To: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: sparse@chrisli.org, linux-sparse@vger.kernel.org

On 07/29/2015 08:26 PM, Tony Camuso wrote:
> [PATCH 1/3] .gitignore: add cscope and Qt project files
> Useful if you're using cscope and Qt as an IDE
>
> [PATCH 2/3] c2xml.c, parse.c: gcc 5+ stricter case statement parsing
> The gcc 5.1.1 compiler complains if any of the possible values for the
> switch variable are not covered by the case statement. Basically, it
> forces the employment of the default case.
>
> [PATCH 3/3] Add NOWARN and NOERR compile conditions
> Provides compile conditionals to buid sparse without reporting
> warnings and errors. This isn't quite reducing it to a tokenizer, but
> it has the same effect for our application. Reports from the semantic
> parser and the time they take are undesirable in our application.
>
>   .gitignore |  7 +++++++
>   c2xml.c    |  2 +-
>   lib.c      | 21 +++++++++++++++++++++
>   parse.c    | 13 +++++++++++++
>   4 files changed, 42 insertions(+), 1 deletion(-)
>

Any chance of this patchset being committed to sparse?

Regards,
Tony


