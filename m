From: Joe Perches <joe@perches.com>
Subject: Re: [PATCH] compiler/compiler-gcc: Add __fallthrough
Date: Fri, 10 Feb 2017 10:50:14 -0800
Message-ID: <1486752614.2192.11.camel@perches.com>
References: <20170210144238.GC15066@kernel.org>
         <791a2621851fc989bc04dfe975ec29de15cbb557.1486746344.git.joe@perches.com>
         <20170210171833.GB14313@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from smtprelay0116.hostedemail.com ([216.40.44.116]:42117 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752380AbdBJSuT (ORCPT
        <rfc822;linux-sparse@vger.kernel.org>);
        Fri, 10 Feb 2017 13:50:19 -0500
In-Reply-To: <20170210171833.GB14313@kernel.org>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Christopher Li <sparse@chrisli.org>, Andrew Morton <akpm@linux-foundation.org>, linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org

On Fri, 2017-02-10 at 14:18 -0300, Arnaldo Carvalho de Melo wrote:
> Em Fri, Feb 10, 2017 at 09:08:35AM -0800, Joe Perches escreveu:
> > gcc v7.0 can warn on missing break statements from case labels
> > using a special __attribute__((fallthrough))__ marker.
> > 
> > Add a __fallthrough convenience macro for gcc versions >= 7 and
> > make the generic use of __fallthrough a no-op.
> 
> Can you state in the log message were this idea came from? Say,
> something like:
> 
> "This was introduced in the tools/include/linux/compiler.h, where it was
> first noticed while buildint tools/perf/ in a Fedora Rawhide
> environment."

The request is from at least 2002.

Maybe Andrew could add a link like:

Link: https://gcc.gnu.org/bugzilla/show_bug.cgi?id=7652

if he applies it.
