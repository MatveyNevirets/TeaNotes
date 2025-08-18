import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:tea_list/core/widgets/are_you_sure_dialog.dart';
import 'package:tea_list/core/widgets/base_gradient_container.dart';
import 'package:tea_list/core/widgets/loading_screen.dart';
import 'package:tea_list/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:tea_list/features/notes/presentation/bloc/notes_bloc.dart';
import 'package:tea_list/features/notes/widgets/note_widget.dart';

class NotesScreen extends StatelessWidget {
  const NotesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is UnauthenticateState) {
            context.go("/");
          }
        },
        builder: (context, state) {
          if (state is AuthLoadingState) {
            return LoadingScreen();
          }
          return CustomScrollView(
            slivers: [
              SliverAppBar(
                toolbarHeight: MediaQuery.of(context).size.height / 12,
                backgroundColor: Colors.black,
                flexibleSpace: Align(
                  alignment: Alignment.topRight,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 36, right: 16),
                    child: IconButton(
                      onPressed:
                          () => showDialog(
                            context: context,
                            builder: (BuildContext dialogContext) {
                              return AreYouSureDialog(
                                onNot: () => Navigator.of(dialogContext).pop(),
                                onYes: () => context.read<AuthBloc>().add(LogoutEvent()),
                                title: "Вы уверены, что хотите выйти из аккаунта?",
                              );
                            },
                          ),
                      icon: Icon(Icons.exit_to_app_rounded, size: 27),
                    ),
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: BaseGradientContainer(height: MediaQuery.of(context).size.height / 25, stops: [0.8, 0.9, 1]),
              ),
              SliverToBoxAdapter(child: SizedBox(height: 16)),
              BlocBuilder<NotesBloc, NotesState>(
                builder: (context, state) {
                  if (state is SuccessFetchedNotesState) {
                    return SliverGrid.builder(
                      itemCount: state.ceremonies.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        return NoteWidget(ceremony: state.ceremonies[index], index: index);
                      },
                    );
                  }
                  if (state is ErrorFetchedNotesState) {
                    return SliverToBoxAdapter(child: Center(child: Text("Упс!.. Что-то пошло не так :(")));
                  }
                  return SliverToBoxAdapter(
                    child: SizedBox(height: MediaQuery.of(context).size.height / 1.4, child: LoadingScreen()),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
