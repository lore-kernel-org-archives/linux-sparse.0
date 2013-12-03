From: Christopher Li <sparse@chrisli.org>
Subject: Re: [PATCH] Update the information in README about using the library.
Date: Tue, 3 Dec 2013 15:17:37 -0800
Message-ID: <CANeU7Qkh-bTrED7HeV-64Ngoi3ZhLZBo96v0mq-wMpCPJkHghA@mail.gmail.com>
References: <1386059165-3812-1-git-send-email-franzschrober@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-sparse-owner@vger.kernel.org>
Received: from mail-oa0-f41.google.com ([209.85.219.41]:59404 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753816Ab3LCXRh (ORCPT
	<rfc822;linux-sparse@vger.kernel.org>);
	Tue, 3 Dec 2013 18:17:37 -0500
Received: by mail-oa0-f41.google.com with SMTP id j17so15994777oag.28
        for <linux-sparse@vger.kernel.org>; Tue, 03 Dec 2013 15:17:37 -0800 (PST)
In-Reply-To: <1386059165-3812-1-git-send-email-franzschrober@gmail.com>
Sender: linux-sparse-owner@vger.kernel.org
List-Id: linux-sparse@vger.kernel.org
To: Franz Schrober <franzschrober@gmail.com>
Cc: Linux-Sparse <linux-sparse@vger.kernel.org>, James Westby <james@jameswestby.net>

That will make you as the author of this commit.
I think not much people have pull from the sparse repository yet.

How about I just roll back and reapply your patch without
the undo part? Of course you need to regenerate a patch with
James' ACK.

The problem is that the next pull from sparse repository
will be a bit messy if you have the abandoned branch already.
Nothing "git reset" can't fix. Hopefully that will not affect a lot of
people.


Chris

On Tue, Dec 3, 2013 at 12:26 AM, Franz Schrober <franzschrober@gmail.com> wrote:
> From: James Westby <james@jameswestby.net>
>
> Changes in the library have left the README giving out of date information
> on how to intialise the library and get the symbols out of it. Update the
> documentation to match the latest functions.
>
> Signed-off-by: James Westby <james@jameswestby.net>
> Signed-off-by: Franz Schrober <franzschrober@gmail.com>
> ---
> This patch was already submitted by James Westby and had to be reverted again
> after he didn't responded in the 4 year relicense process. Now he accepted the
> change to MIT license and I just resubmit it for him. So it is a revert for the
> revert 01b00f59f2a6aba6b623c0a68827938c1f570877 ('Revert "Update the
> information in README about using the library."')
>
> Sorry for the inconveniences.
>
>  README | 29 ++++++++---------------------
>  1 file changed, 8 insertions(+), 21 deletions(-)
>
> diff --git a/README b/README
> index a731a82..033ae15 100644
> --- a/README
> +++ b/README
> @@ -47,35 +47,22 @@ requires the information.
>
>  This means that a user of the library will literally just need to do
>
> -       struct token *token;
> -       int fd = open(filename, O_RDONLY);
> -       struct symbol_list *list = NULL;
> +  struct string_list *filelist = NULL;
> +  char *file;
>
> -       if (fd < 0)
> -               exit_with_complaint();
> +  action(sparse_initialize(argc, argv, filelist));
>
> -       // Initialize parse symbols
> -       init_symbols();
> -
> -       // Tokenize the input stream
> -       token = tokenize(filename, fd, NULL);
> -
> -       // Pre-process the stream
> -       token = preprocess(token);
> -
> -       // Parse the resulting C code
> -       translation_unit(token, &list);
> -
> -       // Evaluate the types now if we want to
> -       // Or leave it until later.
> -       symbol_iterate(list, evaluate_symbol, NULL);
> +  FOR_EACH_PTR_NOTAG(filelist, file) {
> +    action(sparse(file));
> +  } END_FOR_EACH_PTR_NOTAG(file);
>
>  and he is now done - having a full C parse of the file he opened.  The
>  library doesn't need any more setup, and once done does not impose any
>  more requirements.  The user is free to do whatever he wants with the
>  parse tree that got built up, and needs not worry about the library ever
>  again.  There is no extra state, there are no parser callbacks, there is
> -only the parse tree that is described by the header files.
> +only the parse tree that is described by the header files. The action
> +funtion takes a pointer to a symbol_list and does whatever it likes with it.
>
>  The library also contains (as an example user) a few clients that do the
>  preprocessing, parsing and type evaluation and just print out the
> --
> 1.8.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-sparse" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
