From: Tony Camuso <tcamuso@redhat.com>
Subject: Re: [PATCH 0/3] Minor enhancements and fixes
Date: Mon, 3 Aug 2015 14:10:31 -0400
Message-ID: <55BFAE97.8010204@redhat.com>
References: <1438216001-8862-1-git-send-email-tcamuso@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56842 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932132AbbHCSKc (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Mon, 3 Aug 2015 14:10:32 -0400
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

Want to update this prologue to detail the differences in the versions
of the patches in this set.

[PATCH 1/3 v2] .gitignore: add cscope and Qt project files
Inadvertently contained local cruft that I didn't really want in the
.gitignore. The sparse maintainers may want to ignore this patch, as
it's not really a big deal.

[PATCH 2/2 v2] Handle all enum members in case statements
Best practice would specify each of the switch variable's enum values
separately, rather than to lump the unhandled ones into a default.

[PATCH 3/3 v4] Add Wall_off switch to disable errors and warnings
The original version of this patch used compile-time constants.

V2 was a first attempt at using a run-time switch to do the same,
but it wasn't tested properly and did not work as expected.

V3 had the run-time Wall_off switch tested at too high a level, which
required it to be placed in more places than necessary.

V4 puts the Wall_off switch at the lowest level and works as expected.

  .gitignore |  4 ++++
  c2xml.c    | 16 ++++++++++++++++
  lib.c      | 27 +++++++++++++++++++++++----
  lib.h      |  1 +
  parse.c    | 15 +++++++++++++++
  5 files changed, 59 insertions(+), 4 deletions(-)

