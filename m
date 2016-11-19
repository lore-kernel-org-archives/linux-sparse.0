From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: Re: [PATCH 3/5] testsuite: report as error tests known to fail but
 which succeed
Date: Sat, 19 Nov 2016 01:44:12 +0100
Message-ID: <20161119004411.GA20501@macpro.local>
References: <20161102214509.36571-1-luc.vanoostenryck@gmail.com>
 <20161102214509.36571-4-luc.vanoostenryck@gmail.com>
 <CANeU7QnHYuW7-h+wKFcQZe=6xNUZgNdSAtLnqdAm=OBNARvR-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:36093 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751953AbcKSAoQ (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 18 Nov 2016 19:44:16 -0500
Received: by mail-wm0-f68.google.com with SMTP id m203so11246555wma.3
        for <linux-sparse@vger.kernel.org>; Fri, 18 Nov 2016 16:44:15 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QnHYuW7-h+wKFcQZe=6xNUZgNdSAtLnqdAm=OBNARvR-Q@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Nov 18, 2016 at 12:13:58AM +0800, Christopher Li wrote:
> On Thu, Nov 3, 2016 at 5:45 AM, Luc Van Oostenryck
> <luc.vanoostenryck@gmail.com> wrote:
> > Such situation may simply show that what was tested is now fixed
> > and that it's juste the test annotation which need to be adapted,
> > but can be a sign that something else is broken.
> >
> > Reporting the exact result (failure/success, known-to-fail/expect-to-succeed)
> > make the testsuite more useful and allow to use more efficiently
> > git-bisect or other automated testing tools.
> 
> I like what you are doing as a result.
> 
> But I think the implementation has room to improve.
> I don't like deep and messy "else" statement.
> 
> I attach a patch which I modify base on yours. I hope it is
> easier to read. Care to review it?
> 
> Chris

Like I said I prefer your version, but could you add the following patch
on top of yours?

---
From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Date: Sat, 19 Nov 2016 01:28:31 +0100
Subject: [PATCH] testsuite: let the testsuite fail if we got any unexpected
 result

With this patch a failed test but known to fail will still be reported
as failed but won't make the whole testsuite to fail.
But a test known to fail but which succeed will make the testsuite
to fail. Normal tests, the ones not marked as known-to-fail, will
of course the testsuite to fail if one of them fail.

To put things simply: the testsuite will return a failure
if at least one test gave an unexpected result.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 validation/test-suite | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/validation/test-suite b/validation/test-suite
index 4eff0150..ee6a90a5 100755
--- a/validation/test-suite
+++ b/validation/test-suite
@@ -11,6 +11,10 @@ if [ ! -x "$default_path/sparse-llvm" ]; then
 	disabled_cmds="sparsec sparsei sparse-llvm"
 fi
 
+# flags:
+#	- some tests gave an unexpected result
+failed=0
+
 # counts:
 #	- tests that have not been converted to test-suite format
 #	- tests that are disabled
@@ -165,6 +169,8 @@ do_test()
 	must_fail=`expr "$?" = 0`
 	known_ko_tests=`expr $known_ko_tests + $must_fail`
 
+	[ "$test_failed" -eq "$must_fail" ] || failed=1
+
 	if [ "$must_fail" -eq "1" ]; then
 		if [ "$test_failed" -eq "1" ]; then
 			echo "info: test '$file' is known to fail"
@@ -278,5 +284,5 @@ case "$1" in
 		;;
 esac
 
-exit 0
+exit $failed
 
-- 
2.10.2

