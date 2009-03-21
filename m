From: Al Viro <viro@ZenIV.linux.org.uk>
Subject: Re: [bug, bisected, -chrisl] Segfault at evaluate.c:341
Date: Sat, 21 Mar 2009 17:28:23 +0000
Message-ID: <20090321172823.GA5509@ZenIV.linux.org.uk>
References: <154e089b0903190649k7f099c93qedf6eb8e6a1c0a86@mail.gmail.com> <20090319144622.GA28946@ZenIV.linux.org.uk> <154e089b0903191138x15b66808v70bc862d7a13e3c2@mail.gmail.com> <20090319191431.GD28946@ZenIV.linux.org.uk> <70318cbf0903191304k1fefe9afkb4be21550d8f9abe@mail.gmail.com> <20090319215250.GF28946@ZenIV.linux.org.uk> <20090319220906.GG28946@ZenIV.linux.org.uk> <70318cbf0903191611i4ec1f5e5sa97ba53db3a7478c@mail.gmail.com> <20090321044020.GL28946@ZenIV.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from zeniv.linux.org.uk ([195.92.253.2]:52526 "EHLO
	ZenIV.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754495AbZCUR23 (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Sat, 21 Mar 2009 13:28:29 -0400
Content-Disposition: inline
In-Reply-To: <20090321044020.GL28946@ZenIV.linux.org.uk>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Christopher Li <sparse@chrisli.org>
Cc: Hannes Eder <hannes@hanneseder.net>, linux-sparse@vger.kernel.org, Nicholas Mc Guire <der.herr@hofr.at>

On Sat, Mar 21, 2009 at 04:40:20AM +0000, Al Viro wrote:
> On Thu, Mar 19, 2009 at 04:11:41PM -0700, Christopher Li wrote:
> > Thanks Al,
> > 
> > I will apply it later tonight.
> > 
> > If no one beats to me, I will try to add the warning for using preprocessor
> > directive inside macro expansion. It should be a better error message
> > than the current one.
> 
> Well...  patch below would give more or less close approximation to the
> current set of nasal demons produced by gcc in these situations + error
> when that crap happens.
> Warning: it might make things slower, and it needs testing.
> 
> Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
> ---

It needed testing, all right - #elif handling got broken by the initial
variant...  Hopefully fixed version follows:

diff --git a/pre-process.c b/pre-process.c
index cf53893..34b21ff 100644
--- a/pre-process.c
+++ b/pre-process.c
@@ -193,13 +193,36 @@ static void expand_list(struct token **list)
 	}
 }
 
+static void preprocessor_line(struct stream *stream, struct token **line);
+
 static struct token *collect_arg(struct token *prev, int vararg, struct position *pos)
 {
+	struct stream *stream = input_streams + prev->pos.stream;
 	struct token **p = &prev->next;
 	struct token *next;
 	int nesting = 0;
 
 	while (!eof_token(next = scan_next(p))) {
+		if (next->pos.newline && match_op(next, '#')) {
+			if (!next->pos.noexpand) {
+				sparse_error(next->pos,
+					     "directive in argument list");
+				preprocessor_line(stream, p);
+				__free_token(next);	/* Free the '#' token */
+				continue;
+			}
+		}
+		switch (token_type(next)) {
+		case TOKEN_STREAMEND:
+		case TOKEN_STREAMBEGIN:
+			*p = &eof_token_entry;
+			return next;
+		}
+		if (false_nesting) {
+			*p = next->next;
+			__free_token(next);
+			continue;
+		}
 		if (match_op(next, '(')) {
 			nesting++;
 		} else if (match_op(next, ')')) {
@@ -1357,8 +1380,9 @@ static int handle_elif(struct stream * stream, struct token **line, struct token
 	if (token_type(top_if) != TOKEN_IF)
 		return 1;
 	if (false_nesting) {
-		if (expression_value(&token->next))
-			false_nesting = 0;
+		false_nesting = 0;
+		if (!expression_value(&token->next))
+			false_nesting = 1;
 	} else {
 		false_nesting = 1;
 		token_type(top_if) = TOKEN_SKIP_GROUPS;
