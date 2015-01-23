From: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro
Date: Fri, 23 Jan 2015 23:23:32 +0100
Message-ID: <20150123222332.GB42179@macpro.local>
References: <54C15E0E.4000008@de.ibm.com>
 <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:57945 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750823AbbAWWXh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Fri, 23 Jan 2015 17:23:37 -0500
Received: by mail-wi0-f171.google.com with SMTP id l15so14834wiw.4
        for <linux-sparse@vger.kernel.org>; Fri, 23 Jan 2015 14:23:36 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CANeU7QmVQyRFHJ+YSDPkfDfXsNSLL4rJ-jA4v3UQH0tNqjEPOw@mail.gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Linux-Sparse <linux-sparse@vger.kernel.org>

On Fri, Jan 23, 2015 at 08:40:17AM -0800, Christopher Li wrote:
> On Thu, Jan 22, 2015 at 12:31 PM, Christian Borntraeger
> <borntraeger@de.ibm.com> wrote:
> > Linus, Christopher,
> >
> > Commit  0f25c6a78e08fdc15af5e599d836fa24349c042f ("Add warning about duplicate initializers") has a false positive on arch/s390/kvm/kvm-s390.c
> >
> >   CHECK   arch/s390/kvm/kvm-s390.c
> > arch/s390/kvm/kvm-s390.c:1823:1: error: symbol '__UNIQUE_ID_alias__COUNTER__' has multiple initializers (originally initialized at arch/s390/kvm/kvm-s390.c:1822)
> 
> Search the "__COUNTER__" macro shows that:
> https://gcc.gnu.org/onlinedocs/cpp/Common-Predefined-Macros.html
> 
> __COUNTER__This macro expands to sequential integral values starting
> from 0. In conjunction with the ## operator, this provides a
> convenient means to generate unique identifiers. Care must be taken to
> ensure that __COUNTER__ is not expanded prior to inclusion of
> precompiled headers which use it. Otherwise, the precompiled headers
> will not be used.
> 
> I think sparse haven't implement the __COUNTER__ macro. That is why it emit the
> error on duplicate entry.
> 
> Chris
> --


The following patch should fix that.


Luc


Subject: [PATCH] Teach sparse about the __COUNTER__ predefined macro.

Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
---
 ident-list.h                          |  1 +
 pre-process.c                         |  4 ++++
 validation/preprocessor/__COUNTER__.c | 12 ++++++++++++
 3 files changed, 17 insertions(+)
 create mode 100644 validation/preprocessor/__COUNTER__.c

diff --git a/ident-list.h b/ident-list.h
index d5a145f8..b65b667d 100644
--- a/ident-list.h
+++ b/ident-list.h
@@ -108,6 +108,7 @@ __IDENT(__TIME___ident, "__TIME__", 0);
 __IDENT(__func___ident, "__func__", 0);
 __IDENT(__FUNCTION___ident, "__FUNCTION__", 0);
 __IDENT(__PRETTY_FUNCTION___ident, "__PRETTY_FUNCTION__", 0);
+__IDENT(__COUNTER___ident, "__COUNTER__", 0);
 
 /* Sparse commands */
 IDENT_RESERVED(__context__);
diff --git a/pre-process.c b/pre-process.c
index 1aa3d2c4..316247ac 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -181,6 +181,10 @@ static int expand_one_symbol(struct token **list)
 			time(&t);
 		strftime(buffer, 9, "%T", localtime(&t));
 		replace_with_string(token, buffer);
+	} else if (token->ident == &__COUNTER___ident) {
+		static int counter;
+
+		replace_with_integer(token, counter++);
 	}
 	return 1;
 }
diff --git a/validation/preprocessor/__COUNTER__.c b/validation/preprocessor/__COUNTER__.c
new file mode 100644
index 00000000..98187ee6
--- /dev/null
+++ b/validation/preprocessor/__COUNTER__.c
@@ -0,0 +1,12 @@
+__COUNTER__
+__COUNTER__
+/*
+ * check-name: __COUNTER__ #1
+ * check-command: sparse -E $file
+ *
+ * check-output-start
+
+0
+1
+ * check-output-end
+ */
