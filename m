From: "Alexey Zaytsev" <alexey.zaytsev@gmail.com>
Subject: Re: Handling of -specs in cgcc
Date: Tue, 22 Jul 2008 22:11:22 +0400
Message-ID: <f19298770807221111t7277a49ek3931f0b1e5061957@mail.gmail.com>
References: <f19298770807201128s3688702fm3f8b2f42edb198fc@mail.gmail.com>
	 <f19298770807221000o5905fefw44b0f420787baf9e@mail.gmail.com>
	 <118833cc0807221020m44938f77l70324a548baa4551@mail.gmail.com>
	 <f19298770807221028x4f2dca08l36a31a9c381bf4f3@mail.gmail.com>
	 <118833cc0807221043n215f5378pa3f97bdf75452d0a@mail.gmail.com>
	 <1216749832.4485.30.camel@josh-work.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from yw-out-2324.google.com ([74.125.46.31]:32338 "EHLO
	yw-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752256AbYGVSLY (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 22 Jul 2008 14:11:24 -0400
Received: by yw-out-2324.google.com with SMTP id 9so845299ywe.1
        for <linux-sparse@vger.kernel.org>; Tue, 22 Jul 2008 11:11:22 -0700 (PDT)
In-Reply-To: <1216749832.4485.30.camel@josh-work.beaverton.ibm.com>
Content-Disposition: inline
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josht@linux.vnet.ibm.com>
Cc: Morten Welinder <mwelinder@gmail.com>, linux-sparse@vger.kernel.org, Morten Welinder <terra@gnome.org>

On Tue, Jul 22, 2008 at 10:03 PM, Josh Triplett
<josht@linux.vnet.ibm.com> wrote:
> On Tue, 2008-07-22 at 13:43 -0400, Morten Welinder wrote:
>> > But won't gcc fail in such case?
>>
>> It will not fail, as gcc does not see any of it.  But since the defines might
>> not match what gcc runs with, you might get interesting effects.
>>
>> > Maybe we should not remove, but replace it
>> > with a unique option to specify for which architecture sparse should check?
>>
>> That's certainly possible, but I would wait for an actual problem showing
>> up before fixing anything.  Right now, we can use -specs to get an idea
>> what sparse would find for a different arch without actually having a gcc
>> around that can cross compile.
>
> In general, it seems questionable to have cgcc handle an option named
> identically to one in GCC but have it behave differently than GCC.
>
> That said, I do think Sparse should handle different architectures
> without requiring compilation of a "cross-Sparse"; it really just needs
> a specs-equivalent for each architecture.
>
> - Josh Triplett

How about just s/specs/arch/ ?

diff --git a/cgcc b/cgcc
index 4fab530..f4417dc 100755
--- a/cgcc
+++ b/cgcc
@@ -23,7 +23,7 @@ foreach (@ARGV) {
     $m32 = 1 if /^-m32$/;
     $m64 = 1 if /^-m64$/;

-    if (/^-specs=(.*)$/) {
+    if (/^-arch=(.*)$/) {
        $check .= &add_specs ($1);
        $has_specs = 1;
        next;
