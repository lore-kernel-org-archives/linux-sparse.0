From: Pavel Roskin <proski@gnu.org>
Subject: Re: [PATCH] Add a testsuite, call it on "make check"
Date: Tue, 07 Nov 2006 11:08:43 -0500
Message-ID: <1162915723.28006.35.camel@dv>
References: <20061106235142.27050.95901.stgit@dv.roinet.com>
	 <454FD75F.7020600@freedesktop.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from fencepost.gnu.org ([199.232.76.164]:428 "EHLO fencepost.gnu.org")
	by vger.kernel.org with ESMTP id S964857AbWKGQIr (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 7 Nov 2006 11:08:47 -0500
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1GhTVF-0002PU-UI
	for linux-sparse@vger.kernel.org; Tue, 07 Nov 2006 11:08:46 -0500
In-Reply-To: <454FD75F.7020600@freedesktop.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Josh Triplett <josh@freedesktop.org>
Cc: linux-sparse@vger.kernel.org

On Mon, 2006-11-06 at 16:46 -0800, Josh Triplett wrote:
> You rock.  A few comments:
> 
> In the long run, I'd like to check that the expected output matches the actual
> output, rather than just checking for the presence of output; we could do this
> by storing expected warning/error output in a file matching the test but with
> a .err extension.  That won't stop me from committing this test suite
> implementation in the meantime, though.

Actually, the output could be stored in the test itself with a certain
prefix, e.g.:

//experr FILE:3:9: error: undefined identifier 'x'
//experr FILE:4:7: error: incompatible types for 'case' statement

The testsuite would grep for "//experr " and remove it.  Also, "FILE:"
will be substituted with the actual filename.

If no "experr" is found, the output is expected to be empty.  The
"experr" lines should be at the end to avoid the need to change the line
numbers when the error message changes.

> I don't know for sure, since many of the test suite files don't include
> documentation, but I believe that some of them (like the preprocessor tests)
> only run as far as sparse -E, and they don't actually compile as C.  Thus,
> they shouldn't get listed under BAD_EXP_OK.  For these, I'd eventually like to
> check both the preprocessed output and the warning/error output against the
> expected values.

I didn't even know about the "-E" switch.  This reminds us that the
documentation need to be written.

Maybe all the information about the test should be embedded into the
test?  That would be the flags and the expected result.  The only bit of
information stored in the testsuite would be whether the test is known
to pass, and I'm not even sure about that.

> Several tests appear miscategorized in this test suite.  For example,
> struct-ns2.c includes a comment saying "This is not in scope and should barf
> loudly.", and includes code which should indeed cause sparse to barf loudly,
> but sparse does not output anything when run on that file, even with -Wall.

Actually, my patch for -Wall support was never applied, so sparse just
ignores it.  I guess I should resend it.

> Conversely, on initializer-entry-defined-twice.c, sparse actually *should*
> report a problem here (two problems, in fact), and it does; it just shouldn't
> report a problem on the third.  Also, builtin_safe1.c falls in the category of
> "doesn't currently pass", as it warns in two places it shouldn't, in addition
> to the various places it should; however, this would require checking the
> actual warning/error output.  Figuring out which of these various tests should
> pass and which should fail will require a fair bit of work.

I agree.  That's why we want to find the best infrastructure for the
testsuite first.

> Ideally, I'd love to see the test suite find new tests automatically, rather
> than needing to list them explicitly; with a warning/error output file for
> each test, the only difference between an OK_EXP_OK and a BAD_EXP_BAD becomes
> "does the .err file have any content", so that just leaves the known failures,
> which we can list explicitly since we don't need to make it easy to add more.

I think the testsuite can find all files ending with ".c" in the
validation directory.  I guess the tests from phase2 and phase3 could be
moved up and given the ".c" extension as well.  But I have no idea why
those directories were created in the first place.

We also have test-*.c files in the main directory.  They should probably
be moved elsewhere, but I'm not sure if they are suitable for automated
testing.

> Pavel Roskin wrote:
> > --- /dev/null
> > +++ b/validation/testsuite
> > @@ -0,0 +1,118 @@
> > +#! /bin/sh
> > +
> > +set -e
> 
> At first, this seemed wrong, since sparse should exit with a non-zero exit
> code if it emits any errors; however, I then realized that sparse doesn't
> actually *do* this, which seems like a bug.

That's the first bug found by the testsuite :)

I think it would be reasonable to fix it and then rethink the testsuite.

> > +: ${SPARSE=../sparse}
> > +: ${SPARSE_FLAGS=}
> 
> I don't think the test suite should allow setting sparse flags, partly since
> changing the flags may well cause a test to pass or fail when it shouldn't,
> and partly since at some point different parts of the test suite might need
> different flags.

I agree.  However, we need to be able to specify flags for some tests.

> At first I balked a bit at the idea of having the test suite succeed while
> some tests don't actually pass, but more I thought about it, I started to
> agree that it seems like the right approach.  It means that we can ensure that
> the test suite passes in every single Git revision of sparse.  Once all the
> tests run as expected, we can dump this part of the test suite code.

The idea is that the testsuite fails if some tests don't behave as
expected.  This means that the behavior of sparse has changed and the
testsuite needs to be reexamined.  Even if a test that used to fail is
passing now, it needs attention to make sure that the test passes for
legitimate reasons.

It's also very important to catch the cases when sparse produces
different output on different machines.  It's a clear sign that there is
a major bug e.g. an endianess issue or an uninitialized variable.  This
should not be tolerated even temporarily.

I even tend to think that we want to encode the actual output even if
it's known to be wrong.  A flag should indicate that it's not what we
want sparse to do, but it's what it does.  It may be hard to predict the
output from the code that have not be written yet :)

-- 
Regards,
Pavel Roskin
