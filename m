From: Michael Stefaniuc <mstefani@redhat.com>
Subject: Re: Ignore the cdecl and stdcall attributes for now.
Date: Wed, 16 May 2007 13:19:26 +0200
Message-ID: <464AE8BE.9020805@redhat.com>
References: <20070515220536.GA23923@redhat.com> <464AA57B.3010205@freedesktop.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070800090406030504000403"
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mx1.redhat.com ([66.187.233.31]:41170 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757550AbXEPLTk (ORCPT <rfc822;linux-sparse@vger.kernel.org>);
	Wed, 16 May 2007 07:19:40 -0400
In-Reply-To: <464AA57B.3010205@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

This is a multi-part message in MIME format.
--------------070800090406030504000403
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Josh Triplett wrote:
> Michael Stefaniuc wrote:
>> Wine uses the __stdcall__ attribute extensively. The effects of the
>> patch on a sparse run on the Wine code are:
>> - Removes 143000 "attribute '__stdcall__': unknown attribute" errors.
>> - Removes 116 "attribute '__cdecl__': unknown attribute" errors.
>> - Reduces the amount of "error: too many errors" from 1992 to 1459.
>>
>> Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
> 
> Applied, along with a test case.  Thanks!
Thanks.

> I'd love to see the results you get with Wine; in particular, I'd love to see
> and fix any parse errors.  Would you consider posting a build log somewhere
I thankfully accept your offer :)

> with latest Sparse from Git?
The output is still big. But i have a test case for the next big problem 
generator in Wine. It's attached as a git patch to 
validate/calling-convention-attributes.c (I can send it separately to 
the linux-sparse mailing list if you want). Sparse gives:
calling-convention-attributes.c:7:12: error: Expected ; at end of 
declaration
calling-convention-attributes.c:7:12: error: got f5ptr

> Did you integrate Sparse into the Wine build system, or did you use CC=cgcc?
Crude hack in my git tree to Make.rules adding a sparse call to the .c 
=> .o build rule. Tried to see how the Kernel build system integrates 
that and my  head started to smoke ... . I do not plan to send it 
upstream for the moment.

bye
	michael
-- 
Michael Stefaniuc               Tel.: +49-711-96437-199
Sr. Network Engineer            Fax.: +49-711-96437-111
Red Hat GmbH                    Email: mstefani@redhat.com
Hauptstaetterstr. 58            http://www.redhat.de/
D-70178 Stuttgart

--------------070800090406030504000403
Content-Type: text/x-patch;
 name*0="0001-Add-test-for-typedef-on-pointer-to-function-with-std.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename*0="0001-Add-test-for-typedef-on-pointer-to-function-with-std.pa";
 filename*1="tch"

From a31ddd057217701c239677f820fa4bb5456ab079 Mon Sep 17 00:00:00 2001
From: Michael Stefaniuc <mstefani@redhat.com>
Date: Wed, 16 May 2007 13:12:42 +0200
Subject: [PATCH] Add test for typedef on pointer to function with stdcall attribute.


Signed-off-by: Michael Stefaniuc <mstefani@redhat.com>
---
 validation/calling-convention-attributes.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/validation/calling-convention-attributes.c b/validation/calling-convention-attributes.c
index 0546754..1bbe575 100644
--- a/validation/calling-convention-attributes.c
+++ b/validation/calling-convention-attributes.c
@@ -2,3 +2,6 @@ extern void __attribute__((cdecl)) f1(void);
 extern void __attribute__((__cdecl__)) f2(void);
 extern void __attribute__((stdcall)) f3(void);
 extern void __attribute__((__stdcall__)) f4(void);
+
+typedef void (__attribute__((__stdcall__)) *f5)(void);
+typedef f5 f5ptr;
-- 
1.5.0.6


--------------070800090406030504000403--
